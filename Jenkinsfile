pipeline {
    agent {
                label 'swarm-agent'
            }
    stages {
        stage('Build Stage') {
            steps {
                echo "Run docker build Stage"
                sh 'docker build -t artifact:${BUILD_NUMBER} .'
            }
        }
        stage('Tagging Stage') {
            steps {
                echo "Tagging artifacts"
                sh 'docker login -u deployment -p DJe7hOJ7uvYQzj3p nexus.phyzeek.com'
                sh 'docker tag artifact:${BUILD_NUMBER} nexus.phyzeek.com/jenkins-swarm:${BUILD_NUMBER}'
                sh 'docker tag artifact:${BUILD_NUMBER} nexus.phyzeek.com/jenkins-swarm:latest'                
            }
        }
        stage('Push Artifacts Stage') {
            steps {
                echo "Pushing artifacts to registry"
                //sh 'docker push jenkins-swarm:${BUILD_NUMBER}'
                sh 'docker push nexus.phyzeek.com/jenkins-swarm:latest'
            }
        }
        stage('deploy'){
          agent {
            label 'deb-04'
          }
          steps{
            echo "Start deploy"
            sh "docker run -it -p 8080:8080 --rm nexus.phyzeek.com/jenkins-swarm:latest"
          }
        }
    }
}