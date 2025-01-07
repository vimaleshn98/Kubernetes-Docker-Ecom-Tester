# Use an official azure-cli runtime as a base image
FROM bitnami/azure-cli:latest AS azure-cli

# Define build-time arguments
ARG REACT_APP_API_URL

ARG AZURE_DEVOPS_ORG
ARG PAT
ARG AZURE_DEVOPS_PACKAGE
ARG AZURE_DEVOPS_FEED
ARG BUILD_NUMBER

# Set environment variables for use inside the container
ENV REACT_APP_API_URL=${REACT_APP_API_URL}

ENV AZURE_DEVOPS_ORG=${AZURE_DEVOPS_ORG}
ENV PAT=${PAT}
ENV BUILD_NUMBER=${BUILD_NUMBER}
ENV AZURE_DEVOPS_PACKAGE=${AZURE_DEVOPS_PACKAGE}
ENV AZURE_DEVOPS_FEED=${AZURE_DEVOPS_FEED}


# Run azure cli download package
RUN apt-get update && \
    apt-get install libicu-dev -y && \
    az extension add --name azure-devops && \
    echo $PAT | az devops login --organization $AZURE_DEVOPS_ORG && \
    az artifacts universal download --organization $AZURE_DEVOPS_ORG --project $AZURE_DEVOPS_PACKAGE --scope project --feed $AZURE_DEVOPS_FEED --name "reactecom" --version "1.${BUILD_NUMBER}.0" --path "build/"



# Use an official nginx runtime image to run the react build application
FROM nginx:stable-alpine3.20 AS nginx-runner

COPY --from=azure-cli build /usr/share/nginx/html

# Copy a custom NGINX configuration file (optional)
COPY nginx.conf /etc/nginx/nginx.conf

# Expose the default port for Nginx
EXPOSE 80

# Nginx will automatically serve the static files when run
CMD ["nginx", "-g", "daemon off;"]