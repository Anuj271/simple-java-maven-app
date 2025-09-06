# ---------- Stage 1: Build the JAR ----------
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set working directory inside container
WORKDIR /app

# Copy pom.xml and download dependencies first (caching optimization)
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the rest of the project
COPY src ./src

# Build the application (skip tests if you want faster build)
RUN mvn clean package -DskipTests

# ---------- Stage 2: Run the JAR ----------
FROM eclipse-temurin:17-jdk-alpine

# Set working directory
WORKDIR /app

# Copy the JAR from build stage (target/*.jar will match snapshot/release jars)
COPY --from=build /app/target/*SNAPSHOT.jar app.jar

# Expose application port (adjust if your app uses a different one)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]