# foldingathome-arm64
### `Every penny counts - even a tiny Raspberry Pi`

Container deployment for `Folding@Home`, using ***foldingathome.org*** [official fahclient release here](https://download.foldingathome.org/releases/beta/release/fahclient/debian-stable-arm64/v7.6/)  

Develop environment : `Raspberry Pi 4B(4GB)` `Ubuntu 20.04.1 LTS` `Linux 5.4.0-1025-raspi`  

[Dockhub repository](https://hub.docker.com/r/beastob/foldingathome-arm64)  
fahclient versions :

|     State    | Version  |
|:----------:|:--------------:|
| Success  | `7.6.20`  |
| Error | `7.6.21` | 

## Objectiive
The main objective of this project is to make use of as much as resources we have to fight against diseases, with the help of the excellent tool `folding@home` has already provided.  

My project goal is aiming for Kubernetes deployment with Helm, and any help or suggestions would be very appreciated as I am only just stepping into k8s.

## Deploy container
### Pull latest image
```shell script
$ docker pull beastob/foldingathome-arm64
```
### Pull specify image version
```shell script
$ docker pull beastob/foldingathome-arm64:v7.6.14
```

### Deploy container in background and bind web port to host
```shell script
$ docker run -d -p 7396:7396 beastob/foldingathome-arm64
```
You should now be able to access the web console via `http://<server-ip>:7396`

### Deploy container with custom ENV config
```shell script
$ docker run -d -p 7396:7396 --restart=always \
  -e FOLD_USER=elonmusk -e FOLD_PASSKEY=xxxxxxxxxx -e FOLD_ANON=false -e FOLD_ALLOW_IP='192.168.1.101' \
  beastob/foldingathome-arm64
```

## Container info
### fahclient
Currently using `debian-stable-arm64` release from ***foldingathome.org*** [release here](https://download.foldingathome.org/releases/beta/release/fahclient/debian-stable-arm64/v7.6/)

### Web console
Port number: `7396`

### ENV

|     ENV    | default value  | description  |
|:----------:|:--------------:|:------------:|  
| FOLD_USER  | Anonymous  | user name |
| FOLD_TEAM  | 0  | team number |
| FOLD_PASSKEY |   | passkey for your account |
| FOLD_ANON  | true | contribute as anonymous  |
| FOLD_POWER  | full  | 'light',"medium','full' - how much CPU power available to fahclient |
| FOLD_ALLOW_IP  |   |  whitelist IP addresses for accessing the web console  |

## TODO list
- ~~Trim down container image size~~ (~150MB -> ~90MB)
- Kubernetes deployment
- Helm chart
