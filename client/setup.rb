#!/usr/local/bin/ruby
#
require 'elasticsearch'

client = Elasticsearch::Client.new(host: 'elasticsearch', log: true)
client.transport.reload_connections!

TRANSPORTATION_INDEX = {
  index: 'transportation',
  body: {
    mappings: {
      bus_time_record: {
        properties: {
          location: {
            type: "geo_point",
          },
        },
      },
    },
  },
}

client.indices.create(TRANSPORTATION_INDEX)
