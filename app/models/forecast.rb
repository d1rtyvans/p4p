class Forecast < ApplicationRecord
  validates :type,    presence: true
  validates :date,    presence: true
  validates :weather_data, presence: true

  # TODO: Validators/schema for json payload to ensure format of data and
  # common keys are present

  belongs_to :resort
end

