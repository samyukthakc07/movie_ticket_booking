pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t movie-booking:%BRANCH_NAME% .'
            }
        }

        stage('Deploy to Test') {
            when {
                branch 'dev'
            }
            steps {
                bat 'docker rm -f movie-test || echo movie-test not found'
                bat 'docker run -d --name movie-test -p 8081:8000 movie-booking:%BRANCH_NAME%'
            }
        }

        stage('Deploy to Production') {
            when {
                branch 'main'
            }
            steps {
                bat 'docker rm -f movie-prod || echo movie-prod not found'
                bat 'docker run -d --name movie-prod -p 8082:8000 movie-booking:%BRANCH_NAME%'
            }
        }
    }
}