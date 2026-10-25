FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /src
COPY . .
RUN mvn -B -DskipTests package

FROM tomcat:10.1-jdk21-temurin
RUN chmod -R g+rwX /usr/local/tomcat && chgrp -R 0 /usr/local/tomcat
COPY --from=build /src/target/helloworld.war /usr/local/tomcat/webapps/ROOT.war
USER 1001
EXPOSE 8080
