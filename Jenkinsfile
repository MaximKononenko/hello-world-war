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
                }
            }
        }
        stage('Tagging Stage') {
            steps {
                echo "Tagging artifacts"
                script {
                    docker.withRegistry('https://nexus.phyzeek.com', '9d41a3ce-2d5c-4c5e-9ec9-fff5c17de14e') {
                        customImage.push("latest")
                    }
                }
                    // sh 'docker login -u ${USER1} -p ${PW1} nexus.phyzeek.com'
                    // sh 'docker tag artifact:latest nexus.phyzeek.com/jenkins-swarm:${BUILD_NUMBER}'
                    // sh 'docker tag artifact:latest nexus.phyzeek.com/jenkins-swarm:latest'
                    //}
            }
        }
        // stage('Push Artifacts Stage') {
        //     steps {
        //         echo "Pushing artifacts to registry"
        //         // sh 'docker push <REGISTRY>/jenkins-swarm:${BUILD_NUMBER}'
        //         sh 'docker push nexus.phyzeek.com/jenkins-swarm:latest'
        //     }
        // }
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