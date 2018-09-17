# docker-kubernetes-ssh-tunnel

A simple dockerized OpenSSH server to enable accessing services in your cluster via a SSH tunnel. My primary usecase is to securly expose access to databases without always having to do a kubernetes port forwarding.

Hint: This image is not specific to kubernetes at all.

## TODOs

* Don't use `root` user
