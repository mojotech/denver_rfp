class BusStop
  attr_reader :id, :lat, :long, :times

  def initialize(params)
    @id = params.fetch(:id)

    @lat = params.fetch(:lat)
    @long = params.fetch(:long)

    @times = params.fetch(:times)
  end

  def attributes
    {
      id: @id,
      lat: @lat,
      long: @long,
      times: @times,
    }
  end
end
