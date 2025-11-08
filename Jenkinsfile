pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Saiprasadgonage/mini_project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t mini_project_image .'
            }
        }

        stage('Run Docker Container') {
            steps {
                // Stop old container if exists
                sh '''
                if [ $(docker ps -q -f name=mini_project_container) ]; then
                    docker stop mini_project_container
                    docker rm mini_project_container
                fi
                docker run -d -p 8080:80 --name mini_project_container mini_project_image
                '''
            }
        }
    }
}
