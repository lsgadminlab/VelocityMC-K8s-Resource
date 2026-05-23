FROM eclipse-temurin:21-jdk AS build

WORKDIR /src

RUN apt-get update && apt-get install -y git

# clone repo
RUN git clone https://github.com/PaperMC/Velocity.git .

# build velocity
RUN ./gradlew build shadowJar

# runtime image
FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=build /src/proxy/build/libs/*-all.jar /app/velocity.jar

EXPOSE 25577

ENTRYPOINT ["java", "-Xms1G", "-Xmx1G", "-jar", "velocity.jar"]
