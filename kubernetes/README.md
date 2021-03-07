# Deploy Folding@Home in Kubernetes

## Modify FoldingAtHome configurations
### Change Folding User/Passkey
Encode your username and passkey into base64 format.
```shell script
echo "<your username/passkey>" | base64
```
Then copy the values and replace them according in the [secret.yml](secret.yml) file

### Change other settings
Modify [configMap.yml](configMap.yml)

## Modify K8s deployment configurations
Please read [official documentation](https://kubernetes.io/docs/home/) for your own preferences.
* Deployment replicas
* Service type (e.g. Loadbalancer, nodePort, etc)
* and more...

## Deploy Instructions
```shell script
kubectl apply -f secret.yml
kubectl apply -f configMap.yml
kubectl apply -f deployment.yml
kubectl apply -f service.yml
```