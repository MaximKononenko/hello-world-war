## Setup local DEV environment on Ubuntu Linux

1. Requirements
2. Setting up required tools
2.1 Docker installation steps
2.2 Jenkins installation steps
2.3 Java installation steps


===============

## 1. Requirements
On your local desktop you should have installed docker engine and JRE.

## 2. Setting up required tools
### 2.1 Docker installation steps
From your ssh console type:
>curl https://get.docker.com/ > get-docker.sh
>chmod +x get-docker.sh
>./get-docker.sh

### 2.2 Jenkins installation steps
From your ssh console type:
>mkdir /var/jenkins_home
>chown -R 1000:1000 /var/jenkins_home
>docker run -d -v /var/jenkins_home:/var/jenkins_home:z -p 80:8080 -p 50000:50000 --name jenkins jenkins/jenkins:lts

You can put your generated ssh keys into _/var/jenkins_home_ so jenkins master will get same access to slaves and deploy destination hosts as on your local. Do not forget set correct permissions as described above.

Login to Jenkins webinterface http://localhost
Go to Manage Jenkins -> Manage Plugin -> Avaliable
Find and install _**"Docker Swarm Plugin"**_.
Go to _Configure System_ and Create new cloud choosing _Docker Swarm_.
Provide _Docker swarm api url_ and test connection. Set new _Docker Agent template_ and set _Label agent_ as _swarm-agent_, _Image_ as _tehranian/dind-jenkins-slave_ and _Host Binds_ as _/var/run/docker.sock:/var/run/docker.sock_
Create new Pipeline job. Set pipeline definition as _"Pipeline script from CSM"_. Put your CSM endpoints and save the Pipeline job. 

### 2.3 Java installation steps
From your ssh console type:
>sudo apt-get update
>sudo apt-get install default-jre -y


This is the simplest possible Java webapp for testing servlet container deployments.  It should work on any container and requires no other dependencies or configuration.
