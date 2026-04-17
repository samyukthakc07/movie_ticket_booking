pipeline {
    agent any

    environment {
        IMAGE_NAME = "movie-django"
        TEST_CONTAINER = "movie-test"
        PROD_CONTAINER = "movie-prod"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Deploy to Test') {
            when {
                branch 'dev'
            }
            steps {
                sh '''
                docker rm -f $TEST_CONTAINER || true
                docker run -d --name $TEST_CONTAINER -p 8081:8000 $IMAGE_NAME
                '''
            }
        }

        stage('Deploy to Production') {
            when {
                branch 'main'
            }
            steps {
                sh '''
                docker rm -f $PROD_CONTAINER || true
                docker run -d --name $PROD_CONTAINER -p 8082:8000 $IMAGE_NAME
                '''
            }
        }
    }
}