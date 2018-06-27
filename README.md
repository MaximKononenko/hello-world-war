## Setup local DEV environment on Ubuntu Linux

1. Requirements  
2. Setting up required tools  
2.1 Docker installation steps  
2.2 Init Docker Swarm  
2.3 Docker API  
2.4 Jenkins installation and configuration steps  
2.4.1 Installing Jenkins  
2.4.2 Setup Docker Swarm plugin  
2.4.3 Setup Credentials  
2.4.4 Setup Pipeline job  
2.5 Java installation steps  
3. References  
___

## 1. Requirements
On your local desktop you should have installed docker engine and JRE.
___
## 2. Setting up required tools
### 2.1 Docker installation steps
From your ssh console type:
```
curl https://get.docker.com/ > get-docker.sh
chmod +x get-docker.sh
./get-docker.sh
```
___
### 2.2 Init Docker Swarm
From your ssh console type:
```
docker swarm init --advertise-addr <Advertised address (format: <ip|interface>[:port])>
```
___
### 2.3 Docker API
Enable docker remote API on docker host
```
vi /lib/systemd/system/docker.service
```
Find the line which starts with ExecStart and adds "-H=tcp://0.0.0.0:2375" to make it look like:
```
ExecStart=/usr/bin/docker daemon -H=fd:// -H=tcp://0.0.0.0:2375
```
Restart service:
```
systemctl daemon-reload
service docker restart
```
___
### 2.4 Jenkins installation and configuration steps
#### 2.4.1 Installing Jenkins
From your ssh console type:
```
mkdir -p /var/jenkins_home
chown -R 1000:1000 /var/jenkins_home
docker run -d -v /var/jenkins_home:/var/jenkins_home:z -p 80:8080 -p 50000:50000 --name jenkins jenkins/jenkins:lts
```
_You can put your generated ssh keys into _/var/jenkins_home_ so jenkins master will get same access to slaves and deploy destination hosts as on your local. Do not forget set correct permissions as described above._
___
#### 2.4.2 Setup Docker Swarm plugin
Login to Jenkins webinterface http://localhost  
Go to **Manage Jenkins -> Manage Plugin -> Avaliable**
Find and install _**"Docker Swarm Plugin"**_.  
Go to _**Configure System**_ and Create new cloud choosing _**Docker Swarm**_ at the bottom of the page.  
Provide _**Docker swarm api url**_ and test connection.  
Set new _**Docker Agent template**_ and set _**Label agent**_ as _**<"NAMING_CONVENTION">**_, _**Image**_ as _**"tehranian/dind-jenkins-slave"**_ and _**Host Binds**_ as _**"/var/run/docker.sock:/var/run/docker.sock"**_  
___
#### 2.4.3 Setup Credentials
You need to setup credentials for ssh git connection and Registry. From the Jenkins main page go to _**Credentials -> (global) -> Add credentials**_  
For ssh Git authentication pick _**Kind**_ as _**SSH Username with private key**_ from dropdown box.  
Set _**Private Key**_ as _**Enter directly**_ and provide your Key.  
Set _**Username**_ as _**<"NAMING_CONVENTION">**_  
Set _**ID**_ as _**<"NAMING_CONVENTION">**_

For ssh Git authentication pick _**Kind**_ as _**Username with password**_ from dropdown box.  
Set _**Username**_ as _**<"REGISTRY_USERNAME">**_  
Set _**Password**_ as _**<"REGISTRY_PASSWD">**_  
Set _**ID**_ as _**<"NAMING_CONVENTION">**_
___
#### 2.4.4 Setup Pipeline job
Create new "Pipeline" job.  
Set pipeline definition as _**"Pipeline script from CSM"**_.  
Put your CSM endpoint.  
Select your credentials item from dropdown box.
Save the Pipeline job. 

### 2.5 Java installation steps
From your ssh console type:
```
sudo apt-get update
sudo apt-get install default-jre -y
```
___
## 3. References
https://emilwypych.com/2017/10/29/how-to-run-jenkins-with-docker/?cn-reloaded=1  
https://jenkinsci.github.io/job-dsl-plugin/#path/pipelineJob-scm-git  
http://www.littlebigextra.com/how-to-enable-remote-rest-api-on-docker-host/  
https://github.com/tehranian/dind-jenkins-slave
