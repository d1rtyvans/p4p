module Forecasts
  class BulkCollectionWorker < ApplicationWorker
    # This may be tied to particular Resorts in the future, need to do
    # more research on where to get more data that is reliable, while also
    # keeping this logic as dynamic and flexible as possible...
    FORECAST_SOURCES = [
      DarkSkyCollectionWorker,
      WeatherbitCollectionWorker,
    ]

    def perform(resort_id)
      FORECAST_SOURCES.each do |worker|
        worker.perform_async(resort_id)
      end
    end
  end
end
