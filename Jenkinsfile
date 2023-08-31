pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
            git url: 'https://github.com/namth1606/ci-cd.git'
                    withMaven {
                      sh 'mvn -B -DskipTests clean package'
                    }
            }
        }

        stage('Test') {
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
