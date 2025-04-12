pipeline {
    agent any

    environment {
        Branch_Name="${env.Branch_Name}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
               }
            }

        stage('Build & Push Docker Image') {
            steps {
                echo "Branch name $Branch_Name"
                sh 'chmod -R 777 ./build.sh'
                sh './build.sh '$Branch_Name''
            }
        }

        stage('Pulled Image and Deploy to Server') {
            steps {
                    sh """
                    scp -o StrictHostKeyChecking=no deploy.sh ec2-user@3.138.170.162:/home/ec2-user/
                    ssh -o StrictHostKeyChecking=no ec2-user@3.138.170.162 "Branch_Name=$Branch_Name bash deploy.sh"
                    """
                }
            }
    }

    post {
        success {
            echo '🎉 Deployment Successful!'
        }
        failure {
            echo '❌ Deployment Failed.'
        }
    }
}