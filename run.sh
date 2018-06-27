docker stop hello_world_war
docker run -it -d -p 8080:8080 --rm --name hello_world_war registry.hub.docker.com/catalinalab/jenkins-swarm:latest