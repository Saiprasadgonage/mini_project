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
                sh 'sudo docker build -t mini_project_image .'
            }
        }

        
        stage('Run Docker Container') {
            steps {
                sh '''
                    # Stop and remove container if it already exists
                    if [ "$(docker ps -aq -f name=mini_project_container)" ]; then
                        sudo docker rm -f mini_project_container
                    fi

                    # Run a fresh container
                    sudo docker run -d -p 8090:80 --name mini_project_container mini_project_image
                '''
            }
        }

    }
}
