module Schema
  TRANSPORTATION = {
    index: "transportation",
    body: {
      "mappings": {
        "bus_time_record": {
          "properties": {
            "actual_arrival": {
              "type": "date",
            },
            "actual_departure": {
              "type": "date",
            },
            "arrival_delta": {
              "type": "long",
            },
            "departure_delta": {
              "type": "long",
            },
            "expected_arrival": {
              "type": "date",
            },
            "expected_departure": {
              "type": "date",
            },
            "location": {
              "type": "geo_point",
            },
            "neighborhood": {
              "type": "text",
              "fields": {
                "keyword": {
                  "type": "keyword",
                  "ignore_above": 256,
                },
              },
            },
            "stop_id": {
              "type": "text",
              "fields": {
                "keyword": {
                  "type": "keyword",
                  "ignore_above": 256,
                },
              },
            },
            "stop_name": {
              "type": "text",
              "fields": {
                "keyword": {
                  "type": "keyword",
                  "ignore_above": 256,
                },
              },
            },
          },
        },
      },
    },
  }
end
