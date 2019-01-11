# Transportation Data API and Dashboard

## Setup
1. Start the required services using docker-compose:

```
  docker-compose start elasticsearch
  docker-compose start kibana
```

2. Create index in elasticsearch:
```
docker-compose run client ./setup.rb
```

3. Generate some data!
```
docker-compose run client ./generate.rb
```

## FAQ
If you need to reset your search index, you can easily do this with:
```
curl -X DELETE http://localhost:9200/transportation
```

Re-run the setup steps to start over.
