pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Saiprasadgonage/mini_project.git'
            }
        }

        stage('Build and Run with Docker Compose') {
            steps {
                sh '''
                    docker compose down || true
                    docker rm -f $(docker ps -aq --filter "name=flask_app") || true
                    docker compose up --build -d
                '''
            }
        }
    }
}
