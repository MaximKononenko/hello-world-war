docker stop hello_world_war
docker run -it -d -p 8080:8080 --rm --name hello_world_war nexus.phyzeek.com/jenkins-swarm:latest