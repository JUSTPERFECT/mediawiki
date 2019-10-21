pipeline {
    agent any
    parameters { 
        choice(name: 'ENVIRONMENT', choices: ['dev', 'stg', 'prod'], description: 'environment to deploy the app')
        choice(name: 'APPLICATION', choices: ['mediawiki'], description: 'environment to deploy the app')
        choice(name: 'ACTION', choices: ['plan','apply'], description: 'terraform action to run')
        booleanParam(name: 'PACKER_BUILD', defaultValue: false, description: 'whether to run the packer or not')
    }
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
                    env.TERRAFORM_LOCATION = "applications/${params.APPLICATION}/"
                    env.PACKER_LOCATION = "${env.TERRAFORM_LOCATION}/packer/"
                }
            }
        }
        stage('packer validate') {
            when {
                expression { params.PACKER_BUILD == true }
            }
            steps {
                dir("${WORKSPACE}/${env.PACKER_LOCATION}") {
                sh """
                    packer validate -var-file=variables.json packer.json
                """
                }
            }
        }
        stage('packer build') {
            when {
                expression { params.PACKER_BUILD == true }
            }
            steps {
                dir("${WORKSPACE}/${env.PACKER_LOCATION}") {
                    sh """
                        packer build -var-file=variables.json packer.json
                    """
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
                    terraform plan -no-color -var-file ${params.ENVIRONMENT}.tfvars
                    """
                    }
                }
            }
        }
        stage('terraform apply') {
            when {
                expression { params.ACTION == "apply" }
            }
			steps {
                script {
                    dir("${WORKSPACE}/${env.TERRAFORM_LOCATION}") {
                    input message: "Check terraform plan , if okay approve ?"
                    echo 'terraform apply started'
                    sh """
                    terraform apply -no-color -var-file ${params.ENVIRONMENT}.tfvars -auto-approve
                    """
                    }
                }
			}
		}
	}
}
