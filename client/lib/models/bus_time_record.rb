class BusTimeRecord

  STOP_LOCATIONS = {
    A: {
      lat: "39.677937",
      lon: "-105.025177",
    },
    B: {
      lat: "39.67854",
      lon: "-105.020896",
    },
    C: {
      lat: "39.679292",
      lon: "-105.024884",
    },
    D: {
      lat: "39.697292",
      lon: "-105.024917",
    },
    E: {
      lat: "39.711463",
      lon: "-105.024884",
    },
    F: {
      lat: "39.737755",
      lon: "-105.02503",
    },
    G: {
      lat: "39.762326",
      lon: "-105.025078",
    },
    H: {
      lat: "39.787847",
      lon: "-105.025034",
    },
  }

  def initialize(params = {})
    @stop_id = params.fetch(:stop_id)
    @location = STOP_LOCATIONS.fetch(@stop_id.to_sym)

    @expected_arrival = params.fetch(:expected_arrival)
    @actual_arrival = params.fetch(:actual_arrival)
    @arrival_delta = @actual_arrival.to_i - @expected_arrival.to_i

    @expected_departure = params.fetch(:expected_departure)
    @actual_departure = params.fetch(:actual_departure)
    @departure_delta = @actual_departure.to_i - @expected_departure.to_i
  end

  def to_h
    {
      stop_id: @stop_id,
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
