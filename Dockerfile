FROM maven:3.8.4-openjdk-17 AS build

WORKDIR /app

COPY . .

RUN mvn package -DskipTests

FROM openjdk:17-jdk-slim

EXPOSE 8080

WORKDIR /app

COPY --from=build /app/medic-test/target/medic-test-1.jar medic-test-1.jar

ENTRYPOINT ["java", "-jar", "medic-test-1.jar"]