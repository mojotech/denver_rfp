# Document Schema for Neighborhood Data
#
# Based on the inferred use-cases, we propose a document index model for storage, consumption, and
# analysis of the neighborhood data. Instead of making Neighborhood a top level bucket into which
# one might place various other types of data, it instead acts as a facet of various types of data.
#
# Elasticsearch and Kibana are excellent tools to aggregate these documents into interesting reports.
# Below is the schema that describes a portion of how we imagine this would work.
#

module Schema
  TRANSPORTATION = {
    index: "transportation",
    body: {
      "mappings": {
        # A Bus Time Record represents an instance of a bus arriving at a given stop.
        "bus_time_record": {
          "properties": {
            # Actual Arrival is the date and time at which the bus stopped at the given location.
            "actual_arrival": {
              "type": "date",
            },
            # Actual Departure is the date and time at which the bus left the given location.
            "actual_departure": {
              "type": "date",
            },
            # Arrival Delta is the number of minutes between when the bus was scheduled to arrive and when the bus actually arrived.
            "arrival_delta": {
              "type": "long",
            },
            # Depature Delta is the number of minutes between when the bus was scheduled to depart and when it actually departed.
            "departure_delta": {
              "type": "long",
            },
            # Expected Arrival is the scheduled time of the bus' arrival at the stop.
            "expected_arrival": {
              "type": "date",
            },
            # Expected Depature is the scheduled time of the bus' departure from the stop.
            "expected_departure": {
              "type": "date",
            },
            # Location is a GeoPoint, which is represented by a lat-long pair.
            # This allows analysts to visualize data on a map to study the relationship between geographic location and timeliness.
            "location": {
              "type": "geo_point",
            },
            # Neighborhood is the name of the neighborhood in which this bus stop resides.
            # For the purposes of demonstration, we're using the name as the unique identifier.
            # Ideally, neighborhoods would have globally unique identifiers that all document types could use to reference them.
            "neighborhood": {
              "type": "text",
              "fields": {
                "keyword": {
                  "type": "keyword",
                  "ignore_above": 256,
                },
              },
            },
            # For the purposes of demonstration, the stop ID is a string which is unique.
            # Much like neighborhoods, ideally these would be globally unique for cross reference.
            "stop_id": {
              "type": "text",
              "fields": {
                "keyword": {
                  "type": "keyword",
                  "ignore_above": 256,
                },
              },
            },
            # Stop Name is the human-readable version of the stop at which this record occured.
            # It is useful for presenting data in visualizations.
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

  DEMOGRAPHIC = {
    index: "demographic",
    body: {
      "mappings": {
        # Household records are snapshots of the demographics for a given household at the time of creation.
        "households": {
          "properties": {
            # Income represents the bracket for this particular household.
            "income": {
              "type": "long",
            },
            # Property Tax is the estimated property tax at the time of the snapshot.
            "property_tax": {
              "type": "long",
            },
            # Occupancy Type is one of "owner" or "renter" and would be helpful in analyzing trends
            # relative to ownership.
            "occupancy_type": {
              "type": "text",
              "fields": {
                "keyword": {
                  "type": "keyword",
                  "ignore_above": 256,
                },
              },
            },
            # Neighborhood is the name of the neighborhood in which this household resides.
            # For the purposes of demonstration, we're using the name as the unique identifier.
            # Ideally, neighborhoods would have globally unique identifiers that all document types could use to reference them.
            "neighborhood": {
              "type": "text",
              "fields": {
                "keyword": {
                  "type": "keyword",
                  "ignore_above": 256,
                },
              },
            },
            # Created At should contain the time of the snapshot.
            "created_at": {
              "type": "date",
            },
          },
        },
      },
    },
  }

  AIR_QUALITY = {
    index: "air_quality",
    body: {
      "mappings": {
        # A snapshot of pollution for a given pollutant at a particular time.
        "pollutant_report": {
          "properties": {
            # Air Quality rating during the snapshot for this pollutant.
            "rating": {
              "type": "long",
            },
            # The name of the pollutant in question, e.g CO2, PM 2.5
            "pollutant": {
              "type": "text",
              "fields": {
                "keyword": {
                  "type": "keyword",
                  "ignore_above": 256,
                },
              },
            },
            # Value in units of µg/m3.
            # See more here: https://www.eea.europa.eu/themes/air/air-quality/resources/glossary/g-m3
            "amount": {
              "type": "long",
            },
            # GeoPoint that represents the location of the sample for this snapshot.
            "location": {
              "type": "geo_point",
            },
            # Neighborhood is the name of the neighborhood in which this household resides.
            # For the purposes of demonstration, we're using the name as the unique identifier.
            # Ideally, neighborhoods would have globally unique identifiers that all document types could use to reference them.
            "neighborhood": {
              "type": "text",
              "fields": {
                "keyword": {
                  "type": "keyword",
                  "ignore_above": 256,
                },
              },
            },
            # Created At should contain the time of the snapshot.
            "created_at": {
              "type": "date",
            },
          },
        },
      },
    },
  }
end
