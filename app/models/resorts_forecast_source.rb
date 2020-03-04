class ResortsForecastSource < ApplicationRecord
  belongs_to :resort
  belongs_to :forecast_source

  validates :resort,          presence: true
  validates :forecast_source, presence: true
end
