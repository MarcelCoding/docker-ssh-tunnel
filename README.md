# Docker SSH Tunnel

[![Releases](https://img.shields.io/github/v/tag/MarcelCoding/docker-ssh-tunnel?label=latest%20version&style=flat-square)](https://github.com/marcelcoding/docker-ssh-tunnel/releases)
[![Build](https://img.shields.io/github/workflow/status/MarcelCoding/docker-ssh-tunnel/CI?label=CI&style=flat-square)](https://github.com/marcelcoding/docker-ssh-tunnel/actions)
[![DockerHub](https://img.shields.io/docker/pulls/marcelcoding/ssh-tunnel?style=flat-square)](https://hub.docker.com/r/marcelcoding/ssh-tunnel)

Docker SSH Tunnel is a pre configured SSH Daemon to tunnel a local port.

## Usage

1. Deploy, see deployment
2. ```
   ssh -N -o ExitOnForwardFailure=yes -o ServerAliveInterval=300 -o ConnectTimeout=5 -g -R 9999:localhost:<local_port> -p 9714 tunnel@<ssh_host>
   ```

As a scripts witch automatically reconnects you could use something like this:
```bash
#!/bin/sh

while :;
do
  echo "Staring SSH tunnel..."
  /usr/bin/ssh -N -o ExitOnForwardFailure=yes -o ServerAliveInterval=300 -o ConnectTimeout=5 -g -R 9999:localhost:<local_port> -p 9714 tunnel@<ssh_host>
  echo "SSH tunnel has exited."
done
```

## Deployment

This image is available in [Docker Hub](https://hub.docker.com/r/marcelcoding/ssh-tunnel) and the
[GitHub Container Registry](https://github.com/users/MarcelCoding/packages/container/package/ssh-tunnel):

```
marcelcoding/ssh-tunnel:latest
ghcr.io/marcelcoding/ssh-tunnel:latest
```

### Docker "run" Command

```bash
docker run \
  -p 9714:22 \  
  -p 8539:9999 \
  -v "${PWD}/keys:/etc/ssh/keys/etc/ssh" \
  -v "${PWD}/authorized_keys:/home/tunnel/.ssh/authorized_keys" \
  --rm \
  marcelcoding/ssh-tunnel:latest
```

### Docker Compose

````yaml
# docker-compose.yaml
version: '3.8'

services:

  ssh-tunnel:
    restart: always
    image: marcelcoding/ssh-tunnel
    volumes: 
      - "./keys:/etc/ssh/keys/etc/ssh"                        # SSH host keys
      - "./authorized_keys:/home/tunnel/.ssh/authorized_keys" # authorized ssh public keys
    ports:
      - "9714:22"   # SSH
      - "8539:9999" # forwarded port
````

## License

[LICENSE](LICENSE)
