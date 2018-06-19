#!/usr/bin/env groovy

//Lets define a unique label for this build.
def label = "buildpod.${env.JOB_NAME}.${env.BUILD_NUMBER}".replace('-', '_').replace('/', '_')
//Lets create a new pod template with jnlp and maven containers, that uses that label.
podTemplate(label: label, containers: [
        containerTemplate(name: 'dind', image: 'docker:stable-dind', ttyEnabled: true, privileged: true),
        containerTemplate(name: 'maven', image: 'maven:alpine', ttyEnabled: true, command: 'cat'),
        containerTemplate(name: 'alpinebash', image: 'bashell/alpine-bash', ttyEnabled: true, command: 'cat'),
        //containerTemplate(name: 'jnlp', image: 'jenkinsci/jnlp-slave:alpine', args: '${computer.jnlpmac} ${computer.name}', ttyEnabled: false)
        ],
        volumes: [
            // for test
            //emptyDirVolume(mountPath: '/mnt/pkg', memory: false),
            // add login, passwd for docker registry
            //configMapVolume(mountPath: '/home/jenkins/.docker', configMapName: 'jenkins-docker-registry')
            secretVolume(mountPath: '/home/jenkins/.docker', secretName: 'docker-private-registry-auth'),
	    secretVolume(mountPath: '/home/jenkins/.kube', secretName: 'kubectl-auth')
        ],
        ) {
def buildNumber = "${env.BUILD_NUMBER}"
def fqdn = "hello"
    //Lets use pod template (refernce by label)
    node(label) {
        if (env.BRANCH_NAME == 'master') {
            stage 'Maven build'
              container(name: 'maven') {
                git 'http://ms@git.lab.int/ms/hello-world-war.git'
                sh 'ls'
                sh 'pwd'
                sh 'mvn package'
                sh 'ls -lsa target/'
              }
            stage 'Docker build'
              container(name: 'dind') {
                sh 'docker version'
                //sh "git tag --sort version:refname | tail -1 > version.tmp"
                sh "docker build -t docker.devopsit.com.ua/ms/hello-world-war/hello-world-war:'${env.BUILD_NUMBER}' ."
                sh "docker push docker.devopsit.com.ua/ms/hello-world-war/hello-world-war:'${env.BUILD_NUMBER}'"
                sh "echo '${env.BUILD_NUMBER}'"
              }
            stage 'Deploy'
              container(name: 'alpinebash') {
                sh 'echo deploy'
		sh 'apk update && apk add openssh-client curl ca-certificates gettext'
		sh 'curl -L https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl'
		sh 'chmod +x /usr/local/bin/kubectl'
		sh """sed -i "s@image_tag@${buildNumber}@" ./.kube-deploy/deploy.yaml"""
		sh 'sed -i "s@myapp@hello@" ./.kube-deploy/deploy.yaml'
	        sh 'sed -i "s@myapp@hello@" ./.kube-deploy/ingress.yaml'
    	        sh 'sed -i "s@myapp@hello@" ./.kube-deploy/svc.yaml'
    	        sh """sed -i "s@fqdn@$fqdn@" ./.kube-deploy/ingress.yaml"""
	        sh 'kubectl apply -f ./.kube-deploy/'
              }
        }
    }
}
