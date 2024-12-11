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
                sh "docker build --network host -t my-website:${env.BUILD_NUMBER} ."
            }
        }

        stage('Publish') {
            when {
                branch 'master'
                expression {
                    sh(script: 'docker ps -a --filter "name=my-website-container" --format "{{.Names}}" | grep -w my-website-container', returnStatus: true) != 0
                }
            }
            steps {
                sh "docker run -d -p 82:80 --name my-website-container my-website:${env.BUILD_NUMBER}"
            }
        }

        stage('Deploy to /var/www/html') {
            when {
                branch 'master'
            }
            steps {
                sh "docker cp . my-website-container:/var/www/html"
            }
        }
    }
}
