# Tine 2.0 Docker Image

[![Try in PWD](https://github.com/play-with-docker/stacks/raw/cff22438cb4195ace27f9b15784bbb497047afa7/assets/images/button.png)](http://play-with-docker.com?stack=https://raw.githubusercontent.com/exmatrikulator/docker-tine20/master/docker-compose.yml)

## Build 
```
docker build -t tine20-server .
```

use Docker Compose or Docker Swarm to deploy Tine 2.0.

### Docker-Compose

```
docker-compose up -d
```

### Docker Swarm

```
docker stack deploy tine20 -c docker-compose.yml
```

open your browser to
http://localhost/setup.php
Login: tine20setup
Password: changeme2 

If nothing happend, be aware, that you aren't trying to connect with IPv6 to a non IPv6 Docker Daemon!
Try, http://127.0.0.1/setup.php instead.

- Accept license
- Tests schould be OK
- Setup Page should be fine as well
- Just pick a "initial Admin User" and password
- Email can be left blank for now
- Select your prefered Apps and click "return to Tine 2.0"
