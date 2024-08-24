pipeline {
    agent {
        label 'ansible-master'
    }
    tools {
        git 'Default'
    }
    stages {
        stage('Echo') {
            steps {
                sh "chmod -R 755 ${env.WORKSPACE}"
            }
        }
        stage('Clone Repository') {
            steps {
                script {
                    // Specify the target directory
                    def targetDir = "${env.WORKSPACE}"
                    // Clone the repository into the specified directory
                    dir(targetDir) {
                        git branch: "main", url: "https://github.com/timothy-toweh/flask-app-project.git"
                    }
                }
            }
        }
        stage('Configure servers') {
            steps {
                sh "cd ${env.WORKSPACE}/ && ansible-playbook configuration.yml -i hosts.ini"
            }
        }
        stage('Build the main project.py') {
            steps {
                sh "cd ${env.WORKSPACE}/ && ansible-playbook -e 'external_yaml_file=project.py' deployment.yml -i hosts.ini"
            }
        }
    }
        post{
            always {
                emailext body: 'Check console output at $BUILD_URL to view the results.', 
                subject: '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!', 
                to: 'timothytoweh1@gmail.com'
            }
        }     
    }