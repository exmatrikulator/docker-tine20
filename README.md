```
docker build -t tine20-server .
```

## Docker-Compose

```
docker-compose up -d
```

## Docker Swarm

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
