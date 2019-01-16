#!/usr/local/bin/ruby

require 'awesome_print'
require 'csv'
require 'elasticsearch'
require 'active_support/time'
require_relative './lib/models/bus_time_record'
require_relative './lib/models/bus_stop'

TRANSPORTATION_INDEX_NAME = 'transportation'

TRANSPORTATION_INDEX = {
  index: TRANSPORTATION_INDEX_NAME,
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

client = Elasticsearch::Client.new(host: 'elasticsearch', log: false)
client.transport.reload_connections!

puts "Removing existing index..."
client.indices.delete(TRANSPORTATION_INDEX)

puts "Creating index......"
client.indices.create(TRANSPORTATION_INDEX)

class Generator
  def generate
    stops = read_bus_stops
    build_records(stops)
  end

  private def build_records(stops)
    days = [ Date.today, Date.tomorrow ]

    days.map do |date|
      stops.map do |stop|
        stop.times.map do |time|
          expected_arrival = DateTime.parse("#{date} #{time} -0700")
          actual_arrival = expected_arrival.advance(seconds: rand(-300..300))

          expected_departure = DateTime.parse("#{date} #{time} -0700")
          actual_departure = expected_departure.advance(seconds: rand(-300..300))

          BusTimeRecord.new({
            stop_id: stop.id,

            expected_arrival: expected_arrival,
            actual_arrival: actual_arrival,

            expected_departure: expected_departure,
            actual_departure: actual_departure,
          })
        end
      end
    end
  end

  private def read_bus_stops
    data = CSV.read('fixtures/paddle.csv', headers: true, return_headers: false).by_col
    data.map do |datum|
      id, times = datum
      BusStop.new({ id: id, lat: 0, long: 0, times: times })
    end
  end
end

records = Generator.new.generate.flatten

puts "Saving records..."
records.map do |record|
  client.index(index: 'transportation', type: 'bus_time_record', body: record.to_h)
end
