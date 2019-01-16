# Transportation Data API and Dashboard

## Setup
1. Start the required services using docker-compose:

```
  docker-compose start elasticsearch
  docker-compose start kibana
```

2. Create index in elasticsearch and genreate data using:
```
docker-compose run client ./setup.rb
```

Note that this will remove any existing data in your elasticsearch index.
