# Klee_Django container

A container used to deploy quickly the web role used by [klee/klee_web](www.github.com/klee/klee_web),
The container is built from a deployed website, to ensure ease of update & changing of hosts
This container exposes a uWSGI socket in /tmp/uwsgi.sock and Django static files in /opt/static

___

## Building
Software needed: Docker, Vagrant if deploying to a virtual machine or ansible
Refer to [klee/klee_web](www.github.com/klee/klee_web) for deployment instructions

```bash
 vagrant provision
 vagrant ssh
 git clone https://github.com/helicopter88/docker_django_klee
 . build.sh
 ```
___

## Running
```bash
 docker run helicopter88/klee_django:<tag>
```
will start everything
#### Note: The socket create by uWSGI is in /tmp/uwsgi.sock, so if it is needed, a volume for /tmp can be used to access it
#### The static files that django collects are in /opt/static, if those are needed, a volume for /opt/static can be used to access them