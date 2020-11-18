
FROM gradle:jdk8 AS build

COPY --chown=gradle:gradle . /project
WORKDIR /project

RUN gradle build --no-daemon

FROM openjdk:8-jre-slim

EXPOSE 8080

COPY --from=build /project/build/libs/*.jar demo.jar

ENTRYPOINT ["java","-jar","demo.jar"]