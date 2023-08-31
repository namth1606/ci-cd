pipeline {
    agent {
            docker {
                image 'maven:3.9.4-eclipse-temurin-17-alpine'
                args '-v /root/.m2:/root/.m2'
            }
    }

    stages {
        stage('Build running') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Test running') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Packaging/Pushing image') {
            steps {
                script {
                    String content = readFile("gradle.properties")
                    Properties properties = new Properties()
                    properties.load(new StringReader(content))

                    def appVersion = properties.getProperty('version')
                    def dockerImageTag = "hoainam1606/wego-be:${appVersion}"

                    withDockerRegistry(credentialsId: 'dockerhub', url: 'https://index.docker.io/v1/') {
                        sh "docker build -t ${dockerImageTag} ."
                        sh "docker push ${dockerImageTag}"
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
