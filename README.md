# Transportation Data API and Dashboard

## Setup
1. Have Docker installed on your machine:

* [Docker for Windows](https://docs.docker.com/v17.09/docker-for-windows/install/)
* [Docker for Mac](https://docs.docker.com/v17.09/docker-for-mac/install/)

2. Navigate to the directory:

3. Build the docker image using docker-compose:
```
  docker-compose build
```

4. Start the required services:

```
  docker-compose start elasticsearch
  docker-compose start kibana
```

5. Create index in elasticsearch and generate data using:
```
  docker-compose run client ./setup.rb
```
  * Note that this will remove any existing data in your elasticsearch index.

6. Point your browser to [http://localhost:5601](http://localhost:5601)
