FROM openjdk:17-jdk-slim
EXPOSE 8080
COPY target/*.jar demo.jar
ENTRYPOINT ["java", "-jar", "demo.jar"]
