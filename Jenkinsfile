pipeline {
    // agent{
    //     label 'executor'
    // }
    
    agent none

    environment {
        // Define currency conversion environment variables
        SPRING_BOOT_APP_NAME = 'spring-boot-microservice-currency-conversion-service'      // Spring Boot app name
        REACT_APP_NAME = "frontend"
        SPRING_BOOT_APP_PORT = 8100                          // Spring Boot application port
        // DOCKER_CURRENCY_CONVERSION_IMAGE_NAME = 'spring-boot-microservice-currency-conversion-service'   // Docker image name
        // DOCKER_CURRENCY_CONVERSION_REGISTRY = 'vimalesh198'            // Docker registry username
        // DOCKER_CURRENCY_CONVERSION_REPO = 'spring-boot-microservice-currency-conversion-service'          // Docker repository name
                
    }
    stages {
        stage('maven version'){
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

        stage("Parallel validation for E-com projects"){
            parallel{
                stage("validation eCommersApp maven project"){
                    agent {
                        docker {
                            image 'maven:3.9.6-eclipse-temurin-17-alpine'
                            args '-v $HOME/.m2:/root/.m2'
                        }
                    }
                    steps{
                        dir("Kubernetes-Docker-Ecom-Tester/${SPRING_BOOT_APP_CURRENCY_CONVERSION_NAME}") {
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
                stage("validation eCommersApp reactjs project"){
                    agent {
                        docker {
                            image 'node:22-alpine3.21'
                            args '-v $HOME/.m2:/root/.m2'
                        }
                    }
                    steps{
                        dir("Kubernetes-Docker-Ecom-Tester/${REACT_APP_NAME}") {
                            sh(script: 'npm run lint')
                        }
                    }
                    post{
                        always{
                            echo(message: 'Reactjs lint validations stage ')
                        }
                        success{
                            echo(message: 'Reactjs lint validations successfull')
                        }
                        unsuccessful{
                            echo(message: 'Reactjs lint validations unsuccessfull')
                        }
                    }
                }
            }
        }
    }

}
