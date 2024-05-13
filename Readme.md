docker build -t biswajit59/azure-devops-agent:latest .

docker push biswajit59/azure-devops-agent:latest

kubectl create secret generic azp-token --from-literal=token='YOUR_PAT_TOKEN'

kubectl delete -f deployment.yaml
