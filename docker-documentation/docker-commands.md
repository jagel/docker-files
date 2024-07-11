# Create container 
The standard file name to create a container is `docker-compose.yml`. On this way is not required the comman argument to look for the file.

```bash
docker-compose up -d
```
- docker-compose: cli command
- up: crate container
- \- d: Runs the containers in the background (detached mode) 

If file name is not standard, file reference is required in docker-compose command

```bash
docker-compose -f filename.yml up -d
```

- \- f: file location *folderlocation/name.extentsion*, *name.extentsion*

It's possible to use multiple files if it is required

```bash 
docker-compose -f file1.yml -f file2.yaml up -d
```

## Include project to containers

Include the command *-p infra*

```bash
docker-compose -f test.yml up -p infra -d
```

# Stop container

```bash
docker-compose -f mysql.yml down
```

Stop container

```
docker ps -a   # List all containers to find the ones using the volume
docker stop <container_id>  # Stop the container using the volume
docker rm <container_id>
```

# logs

```bash
docker-compose -f mysql.yml logs
```

#  Volumes

See details about a specific volume

```bash
docker volume inspect mysql_data
```

First, list all Docker volumes

```bash
docker volume ls
```

See additional information about a specific volume:

```bash
docker volume inspect mysql_data
```

Remove volume

```bash
docker volume rm mysql_data
```

Force Remove All Unused Volumes

```bash
docker volume prune
```