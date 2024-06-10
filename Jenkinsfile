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
            when {
                expression { currentBuild.changeSets.any { it.branch == 'origin/master' } }
            }
            steps {
                script {
                    def containerExists = sh(script: 'docker ps -q -f name=my-website-container', returnStatus: true)
                    if (containerExists == 0) {
                        echo 'Container already running. Skipping Publish step.'
                    } else {
                        echo 'Container not running. Proceeding with Publish step.'
                    }
                }
            }
        }

        stage('Publish') {
            when {
                branch 'master'
            }
            steps {
                sh 'docker run -d -p 82:80 --name my-website-container my-website'
            }
        }

        stage('Deploy to /var/www/html') {
            when {
                branch 'master'
            }
            steps {
                sh 'docker cp . my-website-container:/var/www/htm'
            }
        }
    }
}
