FROM ubuntu:latest AS build

RUN apt-get update
RUN apt-get install openjdk-17-jdk -y
WORKDIR /app
COPY . .

RUN apt-get install maven -y
RUN mvn package -DskipTests

FROM openjdk:17-jdk-slim

EXPOSE 8080

COPY --from=build /app/medic-test/target/medic-test-1.jar medic-test-1.jar

ENTRYPOINT ["java", "-jar", "medic-test-1.jar"]