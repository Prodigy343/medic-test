FROM ubuntu:latest AS build

RUN apt-get update
RUN apt-get install openjdk-17-jdk -y
COPY . .

RUN apt-get install maven -y
RUN mvn install
RUN mvn package

FROM openjdk:17-jdk-slim

EXPOSE 8080

COPY --from=build /medic-test/target/medic-test-1.jar medic-test-1.jar

ENTRYPOINT ["java", "-jar", "medic-test-1.jar"]