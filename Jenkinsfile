pipeline {
    // agent{
    //     label 'executor'
    // }

    agent none

    environment {
        // Define currency conversion environment variables
        SPRING_BOOT_APP_NAME = 'eCommersApp'      // Spring Boot app name
        REACT_APP_NAME = "frontend"
        SPRING_BOOT_APP_PORT = 8100                          // Spring Boot application port
        // DOCKER_CURRENCY_CONVERSION_IMAGE_NAME = 'spring-boot-microservice-currency-conversion-service'   // Docker image name
        // DOCKER_CURRENCY_CONVERSION_REGISTRY = 'vimalesh198'            // Docker registry username
        // DOCKER_CURRENCY_CONVERSION_REPO = 'spring-boot-microservice-currency-conversion-service'          // Docker repository name
        MAVEN_HOME = '/usr/share/maven'  // Set the Maven home path in the container       
        AZURE_DEVOPS_ORG = 'clouduserpaf9b340f'  // Azure DevOps organization
        AZURE_DEVOPS_FEED = 'kubernete' // Azure Artifacts feed name
    }
    stages {
        stage("maven and react js versions used here"){
            parallel{
                stage('Maven version'){
                    agent {
                        docker {
                            image 'maven:3.9.6-eclipse-temurin-21-alpine'
                            args '-v $HOME/.m2:/root/.m2'
                        }
                    }
                    steps{
                        sh(script: 'mvn --version')
                        sh(script: 'java --version')
                    }
                    post{
                        always{
                            echo(message: 'maven version stage ')
                        }
                    }
                }
                stage('Rectjs version'){
                    agent {
                        docker {
                            image 'node:22-alpine3.21'
                            args '-v $HOME/.m2:/root/.m2'
                        }
                    }
                    steps{
                        sh(script: 'node --version')
                    }
                    post{
                        always{
                            echo(message: 'maven version stage ')
                        }
                    }
                }
            }
        }
        stage("validation eCommersApp maven project"){
                agent {
                    docker {
                        image 'maven:3.9.6-eclipse-temurin-21-alpine'
                        args '--user root'
                    }
                }
                steps{
                    dir("${SPRING_BOOT_APP_NAME}") {
                        sh(script: 'mvn clean validate')
                    }
                }
                post{
                    always{
                        echo(message: 'maven validations stage ')
                    }
                    success{
                        echo(message: 'maven validations successfull')
                    }
                    unsuccessful{
                        echo(message: 'maven validations unsuccessfull')
                    }
                }
        }
        stage('Parallel Build artifacts eCommersApp project'){
            parallel {
                stage("Build eCommersApp java project"){
                    agent {
                        docker {
                            image 'maven:3.9.9-eclipse-temurin-21-alpine'
                            args '-v $HOME/.m2:/root/.m2 --user root'
                        }
                    }
                    steps{
                        dir("${SPRING_BOOT_APP_NAME}") {
                            sh(script: 'mvn -B -DskipTests clean package')
                        }
                    }
                    post{
                        always{
                            echo(message: 'maven build stage ')
                        }
                        success{
                            echo(message: 'maven build successfull')
                            archiveArtifacts artifacts: "${SPRING_BOOT_APP_NAME}/target/*.jar"
                        }
                        unsuccessful{
                            echo(message: 'maven build unsuccessfull')
                        }
                    }
                }
                stage("Build eCommersApp ReactJs project"){
                    agent {
                        docker {
                            image 'node:22-alpine3.21'
                            args '-v $HOME/.m2:/root/.m2'
                        }
                    }
                    steps{
                        dir("${REACT_APP_NAME}") {
                            sh(script: 'npm install')
                            withEnv(['CI=false']) {
                                sh(script: 'npm run build')
                            }
                        }
                    }
                    post{
                        always{
                            echo(message: 'ReactJs artifacts stage ')
                        }
                        // success{
                        //     echo(message: 'ReactJs artifacts stage successfull')
                        //     input message: 'Do you want to proceed with the deployment?', ok: 'Yes, deploy'
                        //     archiveArtifacts allowEmptyArchive: true, artifacts: "${REACT_APP_NAME}/build/**/*", fingerprint: true
                        //     archiveArtifacts allowEmptyArchive: true, artifacts: "${REACT_APP_NAME}/**", excludes: "${REACT_APP_NAME}/node_modules/**"
                        // }
                        success {
                            echo(message: 'ReactJs artifacts stage successful')
                            
                            // Archive the build folder and all files except node_modules
                            archiveArtifacts allowEmptyArchive: true, artifacts: "${REACT_APP_NAME}/build/**/*", fingerprint: true
                            // archiveArtifacts allowEmptyArchive: true, artifacts: "${REACT_APP_NAME}/**", excludes: "${REACT_APP_NAME}/node_modules/**"
                        }

                        unsuccessful{
                            echo(message: 'ReactJs build unsuccessfull')
                        }
                    }
                }
            }
        }
        stage('Upload Artifact to Azure DevOps') {
            agent {
                docker {
                    image 'bitnami/azure-cli:latest'
                    args '--entrypoint=""  -u root'
                }
            }
            when {
                // This stage will run only if the previous stages (Build, Test) succeed.
                expression { currentBuild.result == 'SUCCESS' }
            }
            steps {
                script {
                    // Upload the artifact from Jenkins workspace to Azure DevOps Artifacts
                    withCredentials([string(credentialsId: 'azure_devops_pat', variable: 'PAT')]) {    
                        // Authenticate using Azure CLI                        
                        sh '''
                            az extension add --name azure-devops

                            apt-get update

                            apt-get install libicu-dev -y
                            
                            # Log into Azure DevOps using the injected PAT
                            echo $PAT | az devops login --organization $AZURE_DEVOPS_ORG
                        '''
                        // Dynamically set the version using the Jenkins build number
                        def buildVersion = "1.0.${env.BUILD_NUMBER}"  // Use BUILD_NUMBER for versioning

                        // Define the artifact file path from the workspace (from Jenkins build output)
                        def artifactFile = "${env.WORKSPACE}/${SPRING_BOOT_APP_NAME}/target"  // Modify this path according to your project

                        // Use Azure CLI to upload to Azure Artifacts
                        sh '''
                            az artifacts universal publish \
                                --organization https://dev.azure.com/$AZURE_DEVOPS_ORG \
                                --feed $AZURE_DEVOPS_FEED \
                                --package $SPRING_BOOT_APP_NAME \
                                --version $buildVersion \
                                --path $artifactFile
                        '''

                    }
                }
            }
            post{
                    always{
                        echo(message: 'maven build pushed to Artifacts')
                    }
                    success{
                        echo(message: 'maven build pushed to Artifacts successfull')
                    }
                    unsuccessful{
                        echo(message: 'maven build pushed to Artifacts unsuccessfull')
                    }
                }
        }
    }

}
