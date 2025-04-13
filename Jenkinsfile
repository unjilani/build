pipeline {
    agent any

    environment {
        Branch_Name="${env.Branch_Name}"
        DOCKER_CREDENTIALS = credentials('dockerhub-creds')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
               }
            }
        
        stage('Login to DockerHub') {
            steps {
                sh '''
                    echo "${DOCKER_CREDENTIALS_PSW}" | docker login -u "${DOCKER_CREDENTIALS_USR}" --password-stdin
                '''
               }
            }
        stage('Build & Push Docker Image') {
            steps {
                echo "Branch name $Branch_Name"
                sh "docker system prune -a -f"
                sh 'chmod -R 777 ./build.sh'
                sh "./build.sh $Branch_Name"
            }
        }

        stage('Pulled Image and Deploy to Server') {
            steps {
                    sh "scp -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/jenkins.pem deploy.sh ec2-user@13.58.129.251:/home/ec2-user/"
                    sh "ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/jenkins.pem ec2-user@13.58.129.251 chmod +x ./deploy.sh"
                    sh "ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/jenkins.pem ec2-user@13.58.129.251 ./deploy.sh $Branch_Name"
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