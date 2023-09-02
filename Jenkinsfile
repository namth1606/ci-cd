pipeline {
    agent any

    tools {
        maven 'my-maven'
    }

    stages {

        stage ('Build with Maven') {
            steps {
                sh 'mvn --version'
                sh 'java --version'
                sh 'mvn clean package -Dmaven.test.failure.ignore=true'
            }
        }

        stage ('Packaging/Pushing image') {
            steps {
                withDockerRegistry(credentialsId: 'dockerhub', url: 'https://index.docker.io/v1/') {
                    sh "docker build -t hoainam1606/we-be ."
                    sh "docker push hoainam1606/we-be"
                }
            }
        }

        stage ('Recreating application') {
            steps {
                echo 'Deploying and cleaning'
                sh 'docker rm -f wego-application || echo "this container does not exist" '
                sh 'docker image rm -f hoainam1606/we-be || echo "this image does not exist" '
                sh 'docker run hoainam1606/we-be -d --name wego-application -p 8081:8080'
            }
        }
    }
    post {
        // Clean after build
        always {
            cleanWs()
        }
    }
}