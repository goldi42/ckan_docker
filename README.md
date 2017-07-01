# Docker images for Ckan

Docker images for Ckan 2.5.5

## How to use
Build the Solr Image

```
docker build -t ckan_solr -f Dockerfile.solr .
```

Then Build the ckan app container

```
docker build -t ckan_base .
```

After that start the complete enviornment

```
docker-compose up
```
