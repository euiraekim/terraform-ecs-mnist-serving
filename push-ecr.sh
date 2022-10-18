#!/bin/bash

REGION=$1
ACCOUNT_ID=$2
REPOSITORY=$3

ECR_URL=${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com

aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ECR_URL}

docker build -t ${REPOSITORY}:latest ./server

docker tag ${REPOSITORY}:latest ${ECR_URL}/${REPOSITORY}:latest
docker push ${ECR_URL}/${REPOSITORY}:latest

