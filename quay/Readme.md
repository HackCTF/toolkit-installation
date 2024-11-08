To run the project, edit the config.yaml and docker-compose.yml files

Where {{ip_host}} is replaced with the IP address of the host machine.


execute the command
```sh
podman-compose -d up
```
execute this command for habiliti the posgreql complement
```sh
sudo podman exec -it quay_postgres_1 /bin/bash -c 'echo "CREATE EXTENSION IF NOT EXISTS pg_trgm" | psql -d quay -U quay'
```
##  Robot Access
https://docs.redhat.com/en/documentation/red_hat_quay/3.5/html-single/use_red_hat_quay/index#allow-robot-access-user-repo

https://docs.redhat.com/en/documentation/red_hat_quay/3.13/html-single/use_red_hat_quay/index#creating-robot-account-api

##  Login   

### -  Podman
```sh
podman login quay.io
Username: myusername
Password: mypassword
```
with robot access local not https
edit the file

```sh
nano /etc/containers/registries.conf
# Configuración del registro inseguro (en formato v2)
[[registry]]
location = "192.168.1.70:8080"
insecure = true
```
and execute
```sh
podman login --tls-verify=false -u="neomatrix+robot" -p="E0J28S1DFEMUVYG04JWT3WVL8PCMGAWSQPIO7OKZKFY0YUFFDTBW8FVCYOTCOQE6" localhost:8080
Login Succeeded!
```

#### Create a new container
First we’ll create a container with a single new file based off of the ubuntu base image:
```sh
$ podman run ubuntu echo "fun" > newfile
```
The container will immediately terminate (because its one command is echo), so we’ll use docker ps -l to list it:
```sh
$ podman ps -l
CONTAINER ID        IMAGE               COMMAND             CREATED
07f2065197ef        ubuntu:12.04        echo fun            31 seconds ago
```
Make note of the container id; we’ll need it for the commit command.

#### Tag the container to an image
We next need to tag the container to a known image name

Note that the username must be your Quay username and reponame is the new name of your repository.
```sh
$ podman commit 07f2065197ef {{ip_host}}/username/reponame
e7050e05a288f9f3498ccd2847fee966d701867bc671b02abf03a6629dc921bb
```
####  Push the image to Quay
```sh
$ podman push quay.io/username/reponame
The push refers to a repository [{{ip_host}}/username/reponame] (len: 1)
Sending image list
Pushing repository quay.io/username/reponame (1 tags)
8dbd9e392a96: Pushing [=======>         ] 21.27 MB/134.1 MB 40s
```
#### Pull the image from Quay.io
If any changes were made on another machine, a docker pull can be used to update the repository locally
```sh
$ podman pull {{ip_host}}/username/reponame
```

### -  Docker
```sh
docker login quay.io
Username: myusername
Password: mypassword
```
#### Create a new container
First we’ll create a container with a single new file based off of the ubuntu base image:
```sh
$ docker run ubuntu echo "fun" > newfile
```
The container will immediately terminate (because its one command is echo), so we’ll use docker ps -l to list it:
```sh
$ docker ps -l
CONTAINER ID        IMAGE               COMMAND             CREATED
07f2065197ef        ubuntu:12.04        echo fun            31 seconds ago
```
Make note of the container id; we’ll need it for the commit command.

#### Tag the container to an image
We next need to tag the container to a known image name

Note that the username must be your Quay username and reponame is the new name of your repository.
```sh
$ docker commit 07f2065197ef {{ip_host}}/username/reponame
e7050e05a288f9f3498ccd2847fee966d701867bc671b02abf03a6629dc921bb
```
####  Push the image to Quay
```sh
$ docker push {{ip_host}}/username/reponame
The push refers to a repository [{{ip_host}}/username/reponame] (len: 1)
Sending image list
Pushing repository quay.io/username/reponame (1 tags)
8dbd9e392a96: Pushing [=======>         ] 21.27 MB/134.1 MB 40s
```
#### Pull the image from Quay.io
If any changes were made on another machine, a docker pull can be used to update the repository locally
```sh
$ docker pull {{ip_host}}/username/reponame
```
### -  Kubernetes
