require "active_support/time"
require_relative "./bus_time_record"
require_relative "./bus_stop"

class Generator
  def self.generate
    self.new.generate
  end

  def generate
    stops = read_bus_stops
    build_records(stops)
  end

  private def build_records(stops)
    days = Date.today...Date.today.advance(days: 30)

    raw = days.map do |date|
      stops.map do |stop|
        stop.times.map do |time|
          generate_bus_time_record(stop, date, time)
        end
      end
    end

    raw.flatten
  end

  private def generate_bus_time_record(stop, date, time)
    expected_arrival = DateTime.parse("#{date} #{time} -0700")
    actual_arrival = expected_arrival.advance(seconds: rand(-900..900))

    expected_departure = DateTime.parse("#{date} #{time} -0700")
    actual_departure = expected_departure.advance(seconds: rand(-900..900))

    BusTimeRecord.new({
      stop_id: stop.id,
      expected_arrival: expected_arrival,
      actual_arrival: actual_arrival,
      expected_departure: expected_departure,
      actual_departure: actual_departure,
    })
  end

  private def read_bus_stops
    data = CSV.read("fixtures/paddle.csv", headers: true, return_headers: false).by_col
    data.map do |datum|
      id, times = datum
      BusStop.new({id: id, lat: 0, long: 0, times: times})
    end
  end
end
