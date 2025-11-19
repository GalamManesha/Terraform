pipeline {
    agent any

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'prod', 'uat'],
            description: 'Select environment'
        )
    }

    environment {
        AWS_REGION = "ap-south-1"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Init Terraform') {
            steps {
                dir('terraform-workspace') {
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'aws-cred'
                    ]]) {
                        script {
                            def envName = params.ENVIRONMENT

                            sh """
                                terraform init -reconfigure -force-copy -input=false -no-color \
                                    -backend-config=bucket=my-first-bucket-state-file \
                                    -backend-config=key=${envName}/terraform.tfstate \
                                    -backend-config=region=${AWS_REGION}
                            """

                            def workspaces = sh(
                                script: "terraform workspace list",
                                returnStdout: true
                            ).trim().split("\\n").collect { it.replace("*", "").trim() }

                            if (!workspaces.contains(envName)) {
                                sh "terraform workspace new ${envName}"
                            }

                            sh "terraform workspace select ${envName}"
                        }
                    }
                }
            }
        }

        stage('Plan Terraform') {
            steps {
                dir('terraform-workspace') {
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'aws-cred'
                    ]]) {
                        sh """
                            terraform plan -input=false -no-color \
                                -var-file=${params.ENVIRONMENT}.tfvars
                        """
                    }
                }
            }
        }

        stage('Apply Terraform') {
            steps {
                dir('terraform-workspace') {
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'aws-cred'
                    ]]) {
                        sh """
                            terraform apply -auto-approve -input=false -no-color \
                                -var-file=${params.ENVIRONMENT}.tfvars
                        """
                    }
                }
            }
        }
    }
}
