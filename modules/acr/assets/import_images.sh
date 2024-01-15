#!/bin/bash
az acr login --name ${ACR_NAME}
az acr import --name ${ACR_NAME} --source ${SOURCE} --image ${NAME} || true
