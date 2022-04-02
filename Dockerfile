FROM openjdk:11
ARG JAR_FILE=target/calorie-counter-backend.jar
COPY ${JAR_FILE} calorie-counter-backend.jar
ENTRYPOINT ["java","-jar","/calorie-counter-backend.jar"]
