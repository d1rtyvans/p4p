class ApplicationController < ActionController::API
    # TODO: More granular error handling for different cases
    rescue_from StandardError, with: :handle_error

    private

    def handle_error(e)
      err_message = "An unexpected error occured - #{e.class}: #{e.message}"
      Rails.logger.error err_message
      render json: { 'error' => err_message }, status: 500
    end
end
