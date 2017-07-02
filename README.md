# Docker images for Ckan

Docker images for Ckan 2.5.5

## How to use
Build the Solr Image

```
docker build -t ckan_solr -t ckan_solr:2.5.5 -f Dockerfile.solr .
```

Then Build the ckan app container

```
docker build -t ckan_base -t ckan_base:2.5.5 .
```

After that start the complete enviornment

```
docker-compose up
```
