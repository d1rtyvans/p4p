module Api::V1
  class ResortsController < ApplicationController
    def create
      resort = create_resort!
      collect_forecasts(resort.id)
      render json: resort, status: 201
    end

    private

    def create_resort!
      Resort.create!(resort_params)
    end

    def collect_forecasts(resort_id)
      Forecasts::BulkCollectionWorker.perform_async(resort_id)
    end

    def resort_params
      params.require(:resort).permit(:uid, :name, :lat, :lon)
    end
  end
end
