pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Check out the code from GitHub
                checkout scm
            }
        }

        stage('Dependency Check') {
            steps {
                // Use Jenkins' built-in dependency check
                dependencyCheckAnalyzer {
                    // Optional: specify additional options here if needed
                }
            }
        }

        stage('Build') {
            steps {
                // Build your application (e.g., with Maven)
                sh 'mvn clean install'  // Adjust this to your build tool and command
            }
        }

        stage('Integration Testing') {
            steps {
                // Run integration tests
                sh 'mvn verify -Dskip.unit.tests=true'  // Adjust this to your integration testing command
            }
        }

        stage('UI Testing') {
            steps {
                // Run UI tests (e.g., using Selenium)
                sh 'mvn verify -Dskip.integration.tests=true'  // Adjust this to your UI testing command
            }
        }
    }

    post {
        always {
            // Actions to take always, e.g., cleanup
            echo 'Pipeline completed.'
        }
        success {
            // Actions to take on success, e.g., notifications
            echo 'Build and tests passed successfully!'
        }
        failure {
            // Actions to take on failure, e.g., notifications
            echo 'Build or tests failed.'
        }
    }
}
