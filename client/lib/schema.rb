module Schema
  TRANSPORTATION = {
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
end
