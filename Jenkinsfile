pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout code from the repository
                git branch: 'master', url: 'https://github.com/your-repo/your-app.git'
            }
        }
        
        stage('OWASP DependencyCheck') {
            steps {
                // Run OWASP DependencyCheck to identify vulnerabilities
                dependencyCheck additionalArguments: '--format HTML --format XML', odcInstallation: 'OWASP Dependency-Check Vulnerabilities'
            }
        }
        
        stage('Build and Deploy') {
            parallel {
                stage('Build') {
                    agent {
                        docker {
                            image 'maven:3-alpine' // or your preferred build environment
                            args '-v /root/.m2:/root/.m2'
                        }
                    }
                    steps {
                        // Build the application (adjust command as necessary)
                        sh 'mvn -B -DskipTests clean package'
                    }
                }
                stage('Deploy') {
                    agent any
                    steps {
                        // Deploy the application
                        sh './jenkins/scripts/deploy.sh'
                        input message: 'Finished using the website? (Click "Proceed" to continue)'
                        sh './jenkins/scripts/kill.sh'
                    }
                }
            }
        }
        
        stage('UI Testing') {
            agent {
                docker {
                    image 'maven:3-alpine' // Use an image with necessary testing tools
                    args '-v /root/.m2:/root/.m2'
                }
            }
            steps {
                // Run UI tests over HTTP (adjust commands based on your test framework)
                sh 'mvn -B -DskipTests clean package'
                sh 'mvn test'
            }
            post {
                always {
                    // Publish test results (adjust path if needed)
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
    }
    
    post {
        success {
            // Publish dependency check report
            dependencyCheckPublisher pattern: 'dependency-check-report.xml'
        }
        always {
            // Archive artifacts or perform other actions
        }
    }
}
