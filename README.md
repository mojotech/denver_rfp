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

## Dashboard Setup

1. Point your browser to [http://localhost:5601](http://localhost:5601).
2. Under Kibana, selected [Saved Objects](http://localhost:5601/app/kibana#/management/kibana/objects).
3. Click Import on the top right.
4. Click Import under "Please select a JSON file to import" and select `kibana.json` in this repository.
5. Click Import on the bottom right of the drawer.
6. Visit [Dashboard](http://localhost:5601/app/kibana#/dashboards) and select *Arrival Delta Dashboard*.


If you do not see any data, ensure that the time range at the very top right of the screen is set to "Last 1 year".

## Sample REST API Requests

To request all documents related to a given neighborhood, use Elasticsearch's search API
specifying the neighborhood's identifier. After following the setup steps, you can run
this query using cURL.

```sh
curl -X POST http://localhost:9200/_search -H "Content-Type: application/json" --data '
{
  "query": {
    "bool": {
      "must": [
        {
          "term": {
            "neighborhood.keyword": "Athmar Park"
          }
        }
      ]
    }
  }
}'
```

If you wanted to get more specific and limit your request to only transportation records,
adjust the URL of the request as follows. This will result in only transportation documents
that are related to Athman Park.

```sh
curl -X POST http://localhost:9200/transportation/_search -H "Content-Type: application/json" --data '
{
  "query": {
    "bool": {
      "must": [
        {
          "term": {
            "neighborhood.keyword": "Athmar Park"
          }
        }
      ]
    }
  }
}'
```

Finally, if you wanted to apply a date window to your search, Elasticsearch supports a range
query. Below is a request that only fetches transportation documents with actual arrivals
between December 1st, 2018 and January 1st, 2019.

```sh
curl -X POST http://localhost:9200/transportation/_search -H "Content-Type: application/json" --data '
{
  "query": {
    "bool": {
      "must": [
        {
          "term": {
            "neighborhood.keyword": "Athmar Park"
          }
        },
        {
          "range": {
            "actual_arrival": {
              "gt": "2018-12-01T00:00:00-07:00",
              "lt": "2019-01-01T00:00:00-07:00"
            }
          }
        }
      ]
    }
  }
}'
```
