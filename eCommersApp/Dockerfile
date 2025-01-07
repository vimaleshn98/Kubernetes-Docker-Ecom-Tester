# Use an official azure-cli runtime as a base image
FROM bitnami/azure-cli:latest AS azure-cli

# Define build-time arguments
ARG SPRING_BOOT_APP_NAME
ARG SPRING_BOOT_APP_PORT

# Set environment variables for use inside the container
ENV SPRING_BOOT_APP_NAME=${SPRING_BOOT_APP_NAME}
ENV SPRING_BOOT_APP_PORT=${SPRING_BOOT_APP_PORT}

# Define build-time arguments
ARG AZURE_DEVOPS_ORG
ARG PAT
ARG AZURE_DEVOPS_PACKAGE
ARG AZURE_DEVOPS_FEED
ARG BUILD_NUMBER
ARG DB_HOST
ARG DB_PORT
ARG DB_NAME
ARG DB_USERNAME
ARG DB_PASSWORD

# Set environment variables for use inside the container
ENV AZURE_DEVOPS_ORG=${AZURE_DEVOPS_ORG}
ENV PAT=${PAT}
ENV BUILD_NUMBER=${BUILD_NUMBER}
ENV AZURE_DEVOPS_PACKAGE=${AZURE_DEVOPS_PACKAGE}
ENV AZURE_DEVOPS_FEED=${AZURE_DEVOPS_FEED}
ENV DB_HOST=${DB_HOST}
ENV DB_PORT=${DB_PORT}
ENV DB_NAME=${DB_NAME}
ENV DB_USERNAME=${DB_USERNAME}
ENV DB_PASSWORD=${DB_PASSWORD}


# Run azure cli download package
RUN apt-get update && \
    apt-get install libicu-dev -y && \
    az extension add --name azure-devops && \
    echo $PAT | az devops login --organization $AZURE_DEVOPS_ORG && \
    az artifacts universal download --organization $AZURE_DEVOPS_ORG --project $AZURE_DEVOPS_PACKAGE --scope project --feed $AZURE_DEVOPS_FEED --name "javaecom" --version "1.${BUILD_NUMBER}.0" --path "Ecom-0.0.1-SNAPSHOT.jar"


# Use an official OpenJDK runtime image to run the Spring Boot application
FROM openjdk:11-jre-slim AS java-runtime

# Set the working directory
WORKDIR /app

# Copy the Spring Boot app JAR from the Azure CLI stage
COPY --from=azure-cli Ecom-0.0.1-SNAPSHOT.jar /app/

# Expose the port for the Spring Boot application
EXPOSE ${SPRING_BOOT_APP_PORT}

# Run the Spring Boot application
ENTRYPOINT java -jar /app/Ecom-0.0.1-SNAPSHOT.jar


# Set the Spring datasource properties using environment variables
ENV SPRING_DATASOURCE_URL=jdbc:mysql://${DB_HOST}:${DB_PORT}/${DB_NAME}
ENV SPRING_DATASOURCE_USERNAME=${DB_USERNAME}
ENV SPRING_DATASOURCE_PASSWORD=${DB_PASSWORD}

