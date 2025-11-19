pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-cred')
        AWS_SECRET_ACCESS_KEY = credentials('aws-cred')
        AWS_DEFAULT_REGION    = "ap-south-1"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/GalamManesha/Terraform.git'
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform-workspace') {
                    sh '''
                        terraform init \
                        -backend-config="bucket=my-terraform-state-bucket-ap-south-1" \
                        -backend-config="key=env/dev/terraform.tfstate" \
                        -backend-config="region=ap-south-1"
                    '''
                }
            }
        }

        stage('Select Workspace') {
            steps {
                dir('terraform-workspace') {
                    sh '''
                        terraform workspace select dev || terraform workspace new dev
                    '''
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform-workspace') {
                    sh '''
                        terraform plan
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform-workspace') {
                    sh '''
                        terraform apply -auto-approve
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Success'
        }
        failure {
            echo 'Failed'
        }
    }
}

