# Yaml file composition

File extension common used `.yml` but it also could be `.yaml`
```yaml
version: '3.8' #Specifies the version of Docker Compose.

services: # Defines the services to be run.
  mysql: #The service name.
    image: mysql:8.0 # Specifies the Docker image to use.
    container_name: mysql_container # Names the container.
    restart: always # Ensures the container restarts automatically if it stops.
    environment: # Sets environment variables for the MySQL instance.
      MYSQL_ROOT_PASSWORD: ${value} # environment variable and value stored in file .env
      MYSQL_DATABASE: example_db # environment variable and value
    ports:
      - "3306:3306" # Maps port 3306 on the host to port 3306 on the container.
    volumes:
      - mysql_data:/var/lib/mysql # Defines volumes to persist data.

volumes:
  mysql_data:

# Indentation level 1
 # Indentation level 2
  # - property
```

