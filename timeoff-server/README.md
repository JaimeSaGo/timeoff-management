# Extra configuration for start the services for jfrog


### Create Artifactory service unit file.

```shell
sudo vim /etc/systemd/system/artifactory.service
```

### Add:

```shell
[Unit]
Description=Setup Systemd script for Artifactory Container
After=network.target

[Service]
Restart=always
ExecStartPre=-/usr/bin/docker kill artifactory
ExecStartPre=-/usr/bin/docker rm artifactory
ExecStart=/usr/bin/docker run --name artifactory -p 8081:8081 -p 8082:8082 \
  -v /jfrog/artifactory:/var/opt/jfrog/artifactory \
  docker.bintray.io/jfrog/artifactory-oss:latest
ExecStop=-/usr/bin/docker kill artifactory
ExecStop=-/usr/bin/docker rm artifactory

[Install]
WantedBy=multi-user.target
```


### Reload systemd.

```shell
sudo systemctl daemon-reload
```

### Then start Artifactory container with systemd.

```shell
sudo systemctl start artifactory
```

### Enable it to start at system boot.

```shell
sudo systemctl enable artifactory
```

#### Status can be checked with:

```shell
sudo systemctl status artifactory
```

## Access Artifactory Web Interface

```shell
http://SERVERIP_OR_DOMAIN:8081/artifactory
```

user: admin
Password: password