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
                sh "./build.sh $Branch_Name"
            }
        }

        stage('Pulled Image and Deploy to Server') {
            steps {
                    sh """
                    sshpass -p "34341983Umer!" scp -v -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/jenkins.pem deploy.sh ec2-user@18.191.215.194:/home/ec2-user/
                    sshpass -p "34341983Umer!" ssh -v -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/jenkins.pem ec2-user@18.191.215.194 "Branch_Name=$Branch_Name bash deploy.sh"
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