FROM adoptopenjdk:17-jre-hotspot
EXPOSE 8080
COPY target/*.jar demo.jar
ENTRYPOINT ["java", "-jar", "demo.jar"]
