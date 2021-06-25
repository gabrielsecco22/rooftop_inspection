# Rooftop inspection
This is an IoT project designed to receive frames from drone flight and process them to discover damaged areas in rooftops.

## Requirements
- Docker and docker-compose

## Install
- Go to repo root folder
- Start metabase and postgreSQL services in containers:
```console
 docker-compose up -d
```
- Restore database dump:
```console
 cat init.sql | docker exec -i rooftop_inspection_postgres-db_1 psql -U postgres
```

## Metabase
- Acess: `localhost:15010`
- user: `admin@gmail.com`
- pass: admin123

## App database
- host: `localhost:15432`
- database: `postgres`
- user: `postgres`
- password: `postgres`

## Metabase database
- host: `localhost:15432`
- database: `metabase`
- user: `metabase`
- password: `metabase`

## Backup database (postgres + metabase)
```console
docker exec -t rooftop_inspection_postgres-db_1 pg_dumpall -c -U postgres > init.sql
```