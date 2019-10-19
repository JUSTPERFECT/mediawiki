
pipeline {
    agent any
    stages {
        stage('checkout') {
            steps {
				checkout scm
			}
        }
        stage('Environment Preparation') {
            steps {
                echo 'Preparing environment terraform'
                script {
                    env.TERRAFORM_LOCATION = "stacks/mediawiki/"
                }
            }
        }
        stage('terraform clean') {
            steps {
                echo 'cleaning terraform workspace'
                sh "rm -rf .terraform"
            }
        }
        stage('terrafrom init') {
            steps {
                script {
                    dir("${WORKSPACE}/${env.TERRAFORM_LOCATION}") {
                    echo 'terraform init started'
                    sh """
                    terraform init -no-color
                    """
                    }
                }
            }
        }
        stage('terraform plan') {
            steps {
                script {
                    dir("${WORKSPACE}/${env.TERRAFORM_LOCATION}") {
                    echo 'terraform plan started'
                    sh """
                    terraform plan -no-color
                    """
                    }
                }
            }
        }
        stage('terraform apply') {
            when {
                expression { params.action == "apply" }
            }
			steps {
                script {
                    dir("${WORKSPACE}/${env.TERRAFORM_LOCATION}") {
                    input message: "Check terraform plan , if okay approve ?"
                    echo 'terraform apply started'
                    sh """
                    terraform apply -no-color -auto-approve
                    """
                    }
                }
			}
		}
	}
}
