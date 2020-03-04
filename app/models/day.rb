class Day < ApplicationRecord
  belongs_to :resort
  belongs_to :forecast_source

  validates :resort,          presence: true
  validates :forecast_source, presence: true
  validates :type,            presence: true
  validates :date,            presence: true
  validates :weather_data,    presence: true
  validates :last_update,     presence: true

  # TODO: Validators/schema for json payload to ensure format of data and
  # common keys are present
end

