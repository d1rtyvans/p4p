class Outage < ApplicationRecord
  belongs_to :forecast_source

  validates :error_data, presence: true
end
