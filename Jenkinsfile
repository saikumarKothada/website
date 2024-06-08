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
                sh 'docker cp my-website-container:/var/www/html .'
            }
        }
    }
}
