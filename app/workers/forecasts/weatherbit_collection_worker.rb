module Forecasts
  class WeatherbitCollectionWorker < ApplicationWorker
    def perform(resort_id)
      resort    = Resort.find(resort_id)
      collector = WeatherbitCollector.new(resort_id: resort.id,
                                          coords: resort.coords)

      collector.do!
    end
  end
end
