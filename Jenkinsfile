pipeline {
    agent { label 'ansible-master' }

    environment {
        // Define environment variables if needed
        INVENTORY_FILE = 'hosts.ini'
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Clone your repository containing the playbooks and app code
                checkout scm
            }
        }

        stage('Configure Servers') {
            steps {
                // Run the Ansible playbook to configure the servers
                ansiblePlaybook(
                    playbook: 'configure_servers.yml',
                    inventory: "${INVENTORY_FILE}"
                )
            }
        }

        stage('Deploy Flask App') {
            steps {
                // Run the Ansible playbook to deploy the Flask application
                ansiblePlaybook(
                    playbook: 'deploy_flask_app.yml',
                    inventory: "${INVENTORY_FILE}"
                )
            }
        }

        stage('Start') {
            steps {
                // Run the Ansible playbook to start the application
                ansiblePlaybook(
                    playbook: 'start.yml',
                    inventory: "${INVENTORY_FILE}"
                )
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
