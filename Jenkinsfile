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
    post {
        success {
            mail to: 'timothytoweh1@gmail.com',
                 subject: 'Jenkins CI-CD Successful',
                 body: 'Jenkins CI-CD Job was successful, YAAAY'
        }
        failure {
            mail to: 'timothytoweh1@gmail.com',
                 subject: 'Jenkins CI-CD Failed',
                 body: 'Jenkins CI-CD job failed, sorry'
        }
    }
}
