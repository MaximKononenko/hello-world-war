pipeline {
    agent {
                label 'swarm'
            }
    stages {
        stage('Build Stage') {
            steps {
                echo "Run docker build Stage"
                script {
                    def customImage = docker.build("nexus.phyzeek.com/jenkins-swarm:${BUILD_NUMBER}")
                    docker.withRegistry('https://nexus.phyzeek.com', '9d41a3ce-2d5c-4c5e-9ec9-fff5c17de14e') {
                        echo "Pushing artifacts to registry"
                        customImage.push("latest")
                    }
                }
            }
        }
        stage('deploy'){
          agent {
            label 'deb-04'
          }
          steps{
            echo "Start deploy"
            sh "chmod +x ./run.sh && ./run.sh"
          }
        }
    }
}