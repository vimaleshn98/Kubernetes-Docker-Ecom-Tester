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
                
    }
    stages {
        stage("maven and react js versions used here"){
            parallel{
                stage('Maven version'){
                    agent {
                        docker {
                            image 'maven:3.9.6-eclipse-temurin-17-alpine'
                            args '-v $HOME/.m2:/root/.m2'
                        }
                    }
                    steps{
                        sh(script: 'mvn --version')
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
                        image 'maven:3.9.6-eclipse-temurin-17-alpine'
                        args '-v $HOME/.m2:/root/.m2'
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
                            image 'maven:3.9.6-eclipse-temurin-17-alpine'
                            args '-v $HOME/.m2:/root/.m2'
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
                            sh(script: 'npm run build')
                        }
                    }
                    post{
                        always{
                            echo(message: 'ReactJs artifacts stage ')
                        }
                        success{
                            echo(message: 'ReactJs artifacts stage successfull')
                            archiveArtifacts artifacts: "${REACT_APP_NAME}/build"
                            archiveArtifacts artifacts: "${REACT_APP_NAME}/**", excludes: "${REACT_APP_NAME}/node_modules/**"

                        }
                        unsuccessful{
                            echo(message: 'ReactJs build unsuccessfull')
                        }
                    }
                }
            }
        }
    }

}
