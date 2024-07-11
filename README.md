# Docker Files
Setup docker images using official images

> the definitions marked as <some_definition> need to be replaces for a user value

# Create a Network

Why? : To ensure the appropriate configuration and it can simplify managing and accessing services across multiple Docker containers and hosts.

All the containers are registered on the network `nat`
```bash
docker network create nat
```

# Databases 

## Microsoft SQL

Execute the following command to create Microsoft SQL database container

```
docker-compose -f databases/mssql_2019.yml -p databses up -d
```
> Note: Define the value of the following environment variables located in .env file
> -  MSSQL_SA_PASSWORD

## MySQL

Execute the following command to create mysql container

```
docker-compose -f databases/mysql_8.yml -p databses up -d
```

> Note: Define the value of the following environment variables located in .env file
> - MYSQL_ROOT_PASSWORD

> Note: If you are craeting a database at the moment the container is created you also have to define the following environment variables
> - MYSQL_DATABASE -> Just if you are crearing database 
> - MYSQL_USER -> Just if you are crearing database 
> - MYSQL_PASSWORD -> Just if you are creating database 


### Create mysql database

In case you don't want to create a database at the same time you are creating a container, you can use the following script to create a database once the container is runnig

1. Access to conainter sql command line

```
docker exec -it mysql_9 mysql -u root -p 
```
2. Create a new database, username and passwrod to access

```sql
CREATE DATABASE <database_name>;
CREATE USER '<use_name>'@'%' IDENTIFIED BY '<your_password>';
GRANT ALL PRIVILEGES ON <database_name>.* TO '<use_name>'@'%';
FLUSH PRIVILEGES;
```

## PostgreSQL

Execute the following command to create PostgreSQL database container

```
docker-compose -f databases/postgres_16_3.yml -p databses up -d
```

> Note: Define the value of the following environment variables located in .env file
> - POSTGRES_USER
> - POSTGRES_PASSWORD

# Databases managers

##  Adminer 

Execute the following command to create Adminer container to administrate databases

```
docker-compose -f databases/adminer.yml -p databses up -d
```