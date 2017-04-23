# sshd
Tiny openssh server container that can be used to establish an ssh-tunnel to a remote docker environment (or an overlay network) without having to expose container ports.

## Usage
Create a ssh key pair and start the `sshd` container with the public key (pass the key as AUTHORIZED_KEY environment variable). 

You can now login to this sshd container using your private key. Or create a tunnel to the remote docker swarm network.

Example usage in docker-compose file:

```bash
version: "3"

services:
  sshd:
    image: vkandy/sshd
    ports:
      - 2222:22
    networks:
      - my-network
    environment:
      - AUTHORIZED_KEY=ssh-rsa AAAA
```

Example usage as a standalone container:

```bash
docker run -it -e AUTHORIZED_KEY="ssh-rsa AAAA" -p 2222:22 vkandy/sshd
```

## ssh-tunnel
Suppose you have `container:8080` running on a remote host `remotedockerhost`, to access the container port locally, create a tunnel like so:

```bash
ssh -i ~/.ssh/private_key -p 2222 user@remotedockerhost -fNL 9090:container:8080
```

E.g., to access RethinkDB admin interface, create a tunnel to RethinkDB container:

```bash
ssh -i ~/.ssh/private_key -p 2222 user@remotedockerhost -fNL 9090:rethinkdb:8080
```
You can now access RethinkDB admin interface at http://localhost:9090

