# STAGE 1 - Build

FROM maven:alpine as BUILD

WORKDIR /usr/src/hello-world-war
COPY pom.xml .
COPY src ./src/

RUN cd /usr/src/hello-world-war && mvn clean install
 
RUN ls -la /usr/src/hello-world-war

# STAGE 2 - Pack container

FROM tomcat:alpine

ENV VERSION 0.0.1

COPY --from=BUILD /usr/src/hello-world-war/target/hello-world-war*.war /usr/local/tomcat/webapps/hello-world-war.war

EXPOSE 8080/tcp

CMD ["catalina.sh", "run"]
