pipeline {
    agent any

    stages {
        stage('Checkout GITHUB') {
            steps {
               checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'Jenkinstest']], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/Bhanu88/Nginx_kube_terra_ansible.git']]])
            }
        }
        stage('Creating Infa on AWS') {
            steps {
                dir('Jenkinstest/AWS') {
            sh 'terraform init'
            sh 'echo "yes" | terraform apply'
            sh 'sh Ansible_inventory.sh'
            
}
            }
        }
        stage('Configuring Docker and Kubernetes cluster') {
            steps {
                dir('Jenkinstest/Ansible') {
                sh 'ansible-playbook Install.yml'
                sh 'ansible-playbook master.yml'
                sh 'ansible-playbook Workers.yml'
                }
            }
        }
    }
}