# FROM eclipse-temurin:21-jre
# WORKDIR /app
#
# Copy the JAR from Cloud Build output (or from builder stage if building locally)
# COPY target/*.jar app.jar
#
# Expose port (change if your app uses a different port)
# EXPOSE 8080
#
# Run the application
# ENTRYPOINT ["java", "-jar", "app.jar"]

# Dockerfile (simple, minimal)
FROM eclipse-temurin:21-jre AS runtime
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} /app/app.jar
WORKDIR /app
# optional: create non-root user
USER 1000
ENTRYPOINT ["java","-jar","/app/app.jar"]
