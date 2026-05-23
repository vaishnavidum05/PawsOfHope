FROM maven:3.9.4-eclipse-temurin-17 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn package -DskipTests -X

FROM tomcat:10.1-jdk17

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /app/target/PawsOfHope-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

RUN sed -i 's/port="8080"/port="${PORT:-8080}"/' /usr/local/tomcat/conf/server.xml

EXPOSE 8080

CMD ["catalina.sh", "run"]