#!/usr/bin/env bash

if [ "$(. /etc/os-release; echo $NAME)" = "Ubuntu" ]; then
  apt-get update
  apt-get -y install figlet docker.io git apt-transport-https curl python-minimal python-simplejson
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
  cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
	deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
	apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
systemctl daemon-reload
systemctl restart kubelet
apt-get install -y python-minimal python-simplejson
  SSH_USER=ubuntu
else
  yum install epel-release -y
  yum install figlet docker.io git python-minimal python-simplejson -y
  cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kube*
EOF
setenforce 0
yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
systemctl enable kubelet && systemctl start kubelet
  SSH_USER=ec2-user
fi
# Generate system banner
figlet "${welcome_message}" > /etc/motd

##
## Setup SSH Config
##
cat <<"__EOF__" > /home/SSH_USER/.ssh/config
Host *
    StrictHostKeyChecking no
__EOF__
chmod 600 /home/$SSH_USER/.ssh/config
chown $SSH_USER:$SSH_USER /home/SSH_USER/.ssh/config

${user_data}