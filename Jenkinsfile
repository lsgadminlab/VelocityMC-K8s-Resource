pipeline {
    agent any

    environment {
        IMAGE = "velocity-proxy"
        TAG = "latest"
        REGISTRY = "docker.lsgserver.dev"
    }

    stages {

        stage('Checkout') {
            steps {
                git url: 'https://github.com/PaperMC/Velocity.git'
            }
        }

        stage('Setup Java') {
            steps {
                sh 'java -version'
            }
        }

        stage('Build Velocity') {
            steps {
                sh './gradlew build shadowJar'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                    docker build -t ${IMAGE}:${TAG} .
                """
            }
        }

        stage('Tag') {
            steps {
                sh """
                    docker tag ${IMAGE}:${TAG} ${REGISTRY}/${IMAGE}:${TAG}
                """
            }
        }

        stage('Push') {
            steps {
                sh """
                    docker push ${REGISTRY}/${IMAGE}:${TAG}
                """
            }
        }
    }
}
