# 🚀 Flask + Redis + Jenkins + Docker Compose Integration

This mini project demonstrates **CI/CD integration** using **Jenkins**, **Docker**, and **Docker Compose** to deploy a simple **Flask web app** that connects to a **Redis** backend for counting visits.

---

## 🧩 Project Summary

- **Flask App** → A Python web application that increments and displays a hit counter using Redis.
- **Redis** → An in-memory key-value store for counting the number of visits.
- **Dockerfile** → Defines how to build the Flask app image.
- **Docker Compose** → Orchestrates multiple containers (Flask + Redis).
- **Jenkinsfile** → Automates the build and deployment pipeline.

---

## 📁 Folder Structure

mini_project/
│
├── app/
│   ├── app.py
│   └── requirements.txt
│
├── Dockerfile
├── docker-compose.yml
├── Jenkinsfile
└── README.md

---

## ⚙️ Files Explanation

### 🐍 **app.py**
```python
from flask import Flask
import redis

app = Flask(__name__)
cache = redis.Redis(host='redis', port=6379)

@app.route('/')
def hello():
    count = cache.incr('hits')
    return f'Hello from Flask! I have been seen {count} times.\n'

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=80)

This app connects to Redis (host='redis') and displays how many times the page has been visited.

🐳 Dockerfile
FROM python:3.9-slim
WORKDIR /app
COPY app/requirements.txt .
RUN pip install -r requirements.txt
COPY app/ .
EXPOSE 80
CMD ["python", "app.py"]



Builds a lightweight image for Flask.


Exposes port 80 for the app to listen.



🧱 docker-compose.yml
version: "3.8"
services:
  web:
    build: .
    container_name: flask_app
    ports:
      - "8090:80"
    depends_on:
      - redis
  redis:
    image: redis:alpine
    container_name: redis



Starts both Flask (web) and Redis containers.


Maps host port 8090 → container port 80.



⚙️ Jenkinsfile
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
                    docker compose up --build -d
                '''
            }
        }
    }
}

This Jenkins pipeline:


Pulls the latest code from GitHub.


Builds and deploys the Docker containers using Docker Compose.



🧭 Flow Diagram
flowchart TD
    A[Developer Pushes Code to GitHub] --> B[Jenkins Triggers Build Pipeline]
    B --> C[Checkout Code from GitHub]
    C --> D[Build Docker Image using Dockerfile]
    D --> E[Docker Compose Starts Services]
    E --> F[Flask App Container]
    E --> G[Redis Container]
    F --> G[Flask connects to Redis for hit counter]
    F --> H[Browser Access http://localhost:8090]
    H --> I[Response: "Hello from Flask! I have been seen X times."]


▶️ How to Run Manually (Without Jenkins)


Clone the repository:
git clone https://github.com/Saiprasadgonage/mini_project.git
cd mini_project



Build and start containers:
docker compose up --build -d



Open in browser:
http://localhost:8090



Stop containers:
docker compose down




🧠 Project Flow Summary
StepToolDescription1GitHubDeveloper pushes the latest code2JenkinsAutomatically triggers the pipeline3DockerfileBuilds Flask application image4Docker ComposeStarts Flask & Redis containers5FlaskDisplays web page counting hits6RedisStores and updates visit counter

🧰 Tech Stack
ComponentTechnologyProgrammingPython (Flask)DatabaseRedisCI/CDJenkinsContainerizationDocker & Docker ComposeBase Imagepython:3.9-slim

🌐 Result
Once everything runs successfully:
Visit → http://localhost:8090
You should see:
Hello from Flask! I have been seen 1 times.


📄 License
This project is for learning and demonstration purposes only.
Feel free to fork, modify, and improve!

---

Would you like me to generate this README file as a **ready-to-download `.md` file** (so you can upload it directly to your GitHub repo)?
