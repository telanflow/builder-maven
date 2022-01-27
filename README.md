# KubeSphere DevOps Agent
builder-maven for kubesphere

## Dependency

- maven: 3.8
- openjdk: 11
- git
- docker
- Helm
- kubectl

## How to Build

Enter the directory and execute:

```bash
docker build -t telan/builder-maven:latest -f Dockerfile .
```

## DockerHub

https://hub.docker.com/repository/docker/telan/builder-maven