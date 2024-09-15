pipeline {
    agent { label 'agent01' }

    environment {
        AWS_ACCOUNT_ID = '107895200189'
        AWS_DEFAULT_REGION = 'us-east-1' 
        REPO_NAME = 'zivgl66/pythonapp' 
        IMAGE_TAG = "${env.BUILD_ID}" 
        DOCKER_IMAGE = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${REPO_NAME}:${IMAGE_TAG}"
        GIT_K8S_REPO = "github.com/Zivgl66/Bank_Leumi"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Zivgl66/example-python-web-app'
            }
        }

        stage('Login to AWS ECR') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'aws-ecr-credentials', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh """
                            aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
                            aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
                            aws configure set default.region $AWS_DEFAULT_REGION
                            aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | sudo docker login --username AWS --password-stdin https://${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${REPO_NAME}
                        """
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "sudo docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                script {
                    sh "sudo docker push ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Update GitOps Repo') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'github_token', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD')]) {
                        sh """
                            git clone https://${GIT_K8S_REPO}
                            cd ./Bank_Leumi/Kubernetes
                            sed -i 's|image: .*|image: ${DOCKER_IMAGE}|' deployment.yaml
                            git config --global user.email "jenkins@your-domain.com"
                            git config --global user.name "Jenkins"
                            git add deployment.yaml
                            git commit -m "Update image to ${DOCKER_IMAGE}"
                            git push https://${GIT_USERNAME}:${GIT_PASSWORD}@${GIT_K8S_REPO} HEAD:main
                        """
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}