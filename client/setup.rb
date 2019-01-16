#!/usr/local/bin/ruby

require 'awesome_print'
require 'csv'
require 'elasticsearch'
require_relative './lib/schema'
require_relative './lib/models/generator'

client = Elasticsearch::Client.new(host: 'elasticsearch', log: false)
client.transport.reload_connections!

puts "Removing existing index..."
client.indices.delete(Schema::TRANSPORTATION)

puts "Creating index......"
client.indices.create(Schema::TRANSPORTATION)

puts "Saving records..."
records = Generator.generate

body = records.map do | record|
  { index: { _index: 'transportation', _type: 'bus_time_record', data: record.to_document } }
end

client.bulk(body: body)
