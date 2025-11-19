pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-cred')
        AWS_SECRET_ACCESS_KEY = credentials('aws-cred')
        AWS_DEFAULT_REGION     = "ap-south-1"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/GalamManesha/Terraform.git'
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh '''
                        terraform init
                    '''
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh '''
                        terraform plan
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh '''
                        terraform apply -auto-approve
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '✅ S3 Bucket created successfully!'
        }
        failure {
            echo '❌ Terraform failed! Check logs.'
        }
    }
}
