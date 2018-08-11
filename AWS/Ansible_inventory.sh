#!/bin/bash

terraform output >Ans.properties
sed -i "s/ //g" Ans.properties
file=Ans.properties

IFS='='
while read domain ip
do
echo "[$domain]" | sed -e 's/^[ \t]*//'>>hosts
pub=`aws ec2 describe-instances --instance-id $ip --query 'Reservations[].Instances[].PublicDnsName' --output text`
echo "$pub ansible_ssh_user=ubuntu">>hosts
cat ~/.ssh/id_rsa.pub | ssh -i ~/.ssh/bhanupr.pem -o StrictHostKeyChecking=no ubuntu@$pub 'cat >> .ssh/authorized_keys'
done <"$file"
cp -r hosts ../Ansible/
rm hosts Ans.properties