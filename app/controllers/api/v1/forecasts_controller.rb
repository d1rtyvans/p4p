module Api::V1
  class ForecastsController < ApplicationController
    def index
      # TODO: Handle AR errors
      render json: Forecast.resort_aggregate(resort_uid), status: 200
    end

    private

    def resort_uid
      params.require(:resort_id)
    end
  end
end
