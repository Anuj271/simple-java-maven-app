FROM eclipse-temurin:21-jre
WORKDIR /app

# Copy the JAR from Cloud Build output (or from builder stage if building locally)
COPY target/*.jar app.jar

# Expose port (change if your app uses a different port)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]