REGION=${0}
ACCOUNT_ID=${1}
REPOSITORY=${2}

ECR_URL=${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com

aws ecr get-login-password --region ${REGION} | sudo docker login --username AWS --password-stdin ${ECR_URL}

REPOSITORY=${REPOSITORY}

docker build -t ${REPOSITORY}:${TAG} ./server

docker tag ${REPOSITORY}:latest ${ECR_URL}/${REPOSITORY}:latest
docker push ${ECR_URL}/${REPOSITORY}:latest