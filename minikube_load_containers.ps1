minikube image load test_graphql_apollo:latest
minikube image load supergraph-demo-fed2-inventory:latest
minikube image load supergraph-demo-fed2-products:latest
minikube image load supergraph-demo-fed2-users:latest

## Run Deployment File 
kubectl apply --filename .\graphql\services.yaml
# ARGO STUFF
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl patch svc argocd-server -n argocd -p '{\"spec\": {\"type\": \"LoadBalancer\"}}'

## OPEN ARGOCD PORT 
kubectl port-forward svc/argocd-server -n argocd 8080:443


## Setting up  ARGO CD CLI TOOL ON WINDOWS
$version = (Invoke-RestMethod https://api.github.com/repos/argoproj/argo-cd/releases/latest).tag_name
$url = "https://github.com/argoproj/argo-cd/releases/download/" + $version + "/argocd-windows-amd64.exe"
$output = "argocd.exe"
## Create the .exe 
Invoke-WebRequest -Uri $url -OutFile $output
# Start the argocd cli 
cmd argocd.exe