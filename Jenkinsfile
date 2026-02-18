pipeline {
    agent { label 'jenkins-agent' }

    triggers {
        githubPush()
    }

    environment {
        TF_IN_AUTOMATION = "true"
        TF_VAR_do_token  = credentials('do-token')
    }
    stage('Debug Branch') {
    steps {
        echo "BRANCH_NAME = ${env.BRANCH_NAME}"
        sh 'git branch --show-current || true'
    }
}

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                dir('acm-ss/terraform/envs/dev') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('acm-ss/terraform/envs/dev') {
                    sh 'terraform plan'
                }
            }
        }

        stage('Approval for Apply') {
            when {
                branch 'main'
            }
            steps {
                input message: 'Approve Terraform APPLY to production?'
            }
        }

        stage('Terraform Apply') {
            when {
                branch 'main'
            }
            steps {
                dir('acm-ss/terraform/envs/dev') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}
