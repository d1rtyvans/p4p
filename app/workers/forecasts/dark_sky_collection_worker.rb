module Forecasts
  class DarkSkyCollectionWorker < ApplicationWorker
    def perform(resort_id)
      resort    = Resort.find(resort_id)
      collector = DarkSkyCollector.new(resort_id: resort.id,
                                       coords: resort.coords)

      collector.do!
    end
  end
end
