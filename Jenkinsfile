pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh 'docker build -t my-website .'
            }
        }

        stage('Check Container') {
            steps {
                script {
                    def containerExists = sh(script: 'docker ps -q -f name=my-website-container', returnStatus: true)
                    if (containerExists == 0) {
                        currentBuild.result = 'FAILURE' // Mark the build as failed
                    }
                }
            }
        }

        stage('Publish') {
            when {
                branch 'master'
                expression {
                    currentBuild.result == 'FAILURE' // Only run if container doesn't exist
                }
            }
            steps {
                sh 'docker run -d -p 82:80 --name my-website-container my-website'
            }
        }

        stage('Deploy to /var/www/html') {
            when {
                branch 'master'
                expression {
                    currentBuild.result != 'FAILURE' // Only run if container exists
                }
            }
            steps {
                sh 'docker cp . my-website-container:/var/www/htm'
            }
        }
    }
}
