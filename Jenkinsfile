pipeline {
    agent any

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
                String content = readFile("gradle.properties")
                Properties properties = new Properties()
                properties.load(new StringReader(content))
                withDockerRegistry(credentialsId: 'dockerhub', url: 'https://index.docker.io/v1/') {
                    sh "docker build -t hoainam1606/wego-be:${properties.version} ."
                    sh "docker push hoainam1606/wego-be:${properties.version}"
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
