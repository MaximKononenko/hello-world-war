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
            withCredentials([string(credentialsId: '9d41a3ce-2d5c-4c5e-9ec9-fff5c17de14e', variable: 'PW1')]) {
                echo "My password is '${PW1}'!"
            
            steps {
                echo "Tagging artifacts"
                sh 'docker login -u ${Username} -p ${Password} nexus.phyzeek.com'
                // sh 'docker tag artifact:${BUILD_NUMBER} <REGISTRY>/jenkins-swarm:${BUILD_NUMBER}'
                // sh 'docker tag artifact:${BUILD_NUMBER} <REGISTRY>/jenkins-swarm:latest'                
            }
            }
        }
        stage('Push Artifacts Stage') {
            steps {
                echo "Pushing artifacts to registry"
                // sh 'docker push <REGISTRY>/jenkins-swarm:${BUILD_NUMBER}'
                // sh 'docker push <REGISTRY>/jenkins-swarm:latest'
            }
        }
        stage('deploy'){
          agent {
            label 'deb-04'
          }
          steps{
            echo "Start deploy"
            //sh "docker stop"
            sh "wget https://raw.githubusercontent.com/MaximKononenko/hello-world-war/master/run.sh && chmod +x ./run.sh && ./run.sh"
          }
        }
    }
}