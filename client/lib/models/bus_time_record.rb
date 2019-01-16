require_relative "../../fixtures/stop_meta"

class BusTimeRecord
  def initialize(params = {})
    @stop_id = params.fetch(:stop_id)
    @stop_name = StopMeta::STOP_NAMES.fetch(@stop_id.to_sym)[:name]
    @neighborhood = StopMeta::STOP_NAMES.fetch(@stop_id.to_sym)[:neighborhood]

    @location = StopMeta::STOP_LOCATIONS.fetch(@stop_id.to_sym)

    @expected_arrival = params.fetch(:expected_arrival)
    @actual_arrival = params.fetch(:actual_arrival)
    @arrival_delta = (@actual_arrival.to_i - @expected_arrival.to_i) / 60

    @expected_departure = params.fetch(:expected_departure)
    @actual_departure = params.fetch(:actual_departure)
    @departure_delta = (@actual_departure.to_i - @expected_departure.to_i) / 60
  end

  def to_document
    {
      stop_id: @stop_id,
      stop_name: @stop_name,
      neighborhood: @neighborhood,
      location: @location,
      expected_arrival: @expected_arrival,
      actual_arrival: @actual_arrival,
      arrival_delta: @arrival_delta,
      expected_departure: @expected_departure,
      actual_departure: @actual_departure,
      departure_delta: @departure_delta,
    }
  end
end
