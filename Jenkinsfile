pipeline {
    agent none

    environment {
        AWS_REGION   = 'ap-south-1'
        ECR_REGISTRY = '774305613843.dkr.ecr.ap-south-1.amazonaws.com'
        IMAGE_NAME   = 'terraform-jenkins-agent'
        IMAGE_TAG    = '1.0.0'
        TF_IN_AUTOMATION = 'true'
    }

    stages {

        stage('Checkout') {
            agent any
            steps {
                checkout scm
            }
        }

        stage('Set Environment Context') {
            agent any
            steps {
                script {
                    if (env.BRANCH_NAME == 'dev') {
                        env.TF_ENV = 'dev'
                    } else if (env.BRANCH_NAME == 'stg') {
                        env.TF_ENV = 'stg'
                    } else if (env.BRANCH_NAME == 'main') {
                        env.TF_ENV = 'prod'
                    } else {
                        error "Unsupported branch: ${env.BRANCH_NAME}"
                    }

                    echo "Terraform environment set to: ${env.TF_ENV}"
                }
            }
        }

        stage('Terraform Plan') {
            agent {
                docker {
                    image "${ECR_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
                    reuseNode true
                }
            }
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-ci-user'],
                    string(credentialsId: 'do-token', variable: 'DO_TOKEN')
                ]) {

                    sh """
                        export TF_VAR_do_token=${DO_TOKEN}
                        cd acm-ss/terraform/envs/${TF_ENV}
                        terraform init
                        terraform plan
                    """
                }
            }
        }

        stage('Manual Approval (Prod Only)') {
            when {
                branch 'main'
            }
            steps {
                input message: 'Approve Terraform APPLY to Production?'
            }
        }

        stage('Terraform Apply (Prod Only)') {
            when {
                branch 'main'
            }
            agent {
                docker {
                    image "${ECR_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
                    reuseNode true
                }
            }
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-ci-user'],
                    string(credentialsId: 'do-token', variable: 'DO_TOKEN')
                ]) {

                    sh """
                        export TF_VAR_do_token=${DO_TOKEN}
                        cd acm-ss/terraform/envs/${TF_ENV}
                        terraform apply -auto-approve
                    """
                }
            }
        }   
    }
}