pipeline {
    agent any

    tools {
        maven 'my-maven'
    }

    environment {
          APP_VERSION = readProperties()
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
                script {
                    def pom = readMavenPom(file: 'pom.xml')
                    def version = pom.version
                    echo "Version is: ${version}"
                }
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
                sh "docker run -d --name wego-application -p 8085:8080 hoainam1606/we-be"
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}