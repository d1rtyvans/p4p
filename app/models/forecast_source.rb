class ForecastSource < ApplicationRecord
  has_many :outages,                  dependent: :destroy
  has_many :resorts_forecast_sources, dependent: :destroy
  has_many :resorts,                  through: :resorts_forecast_sources

  validates :name,       presence: true
  validates :klass_name, presence: true

  enum status: %i[
    online
    down
  ]
end
