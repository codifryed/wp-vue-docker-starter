# wp-vue-docker-starter

A starting point using docker-compose and a basic theme for vue integration.


## Instructions:

##Install docker:

sudo apt install apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

sudo apt install docker-ce

sudo systemctl status docker

sudo usermod -aG docker ${USER}
(log out and back in again)

---

##install docker-compose (small exec)
here: https://github.com/docker/compose/releases

sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

---

mkdir of your choice for holding the data of the containers

copy docker-compose.yml to this dir

docker-compose up -d --build  (will initialize and download the images and start them)

---

docker-compose down (will stop and remove the containers)

docker-compose down -v (will also delete the volumes)

docker-compose start

docker-compose stop

docker ps -a

(when container is running:)<br/>
docker exec -it container_name bash   (starts interactive bash session) <br/>
cat /etc/passwd  (to see list of user IDs)<br/>
usermod -u 1000 www-data  ( * currently added to dockerfile aka no more need)

---

alias for wp-cli:<br/>
alias wp='docker exec -it web_init1 wp'

---

#manual sql dump:
docker exec mysql sh -c 'exec mysqldump wordpress -u wordpress -p"wordpress"' > /var/lib/mysql/wordpress.sql

---

##npm vue:

* goto frontend-vue folder
``` bash
# install dependencies
$ npm install

# serve with hot reload at localhost:52000
$ npm run dev

# build for production and launch server
$ npm run build
$ npm start

# build for production and view the bundle analyzer report
$ npm run analyze

# generate static project
$ npm run generate
```
