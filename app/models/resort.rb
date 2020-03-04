class Resort < ApplicationRecord
  has_many :days
  has_many :resorts_forecast_sources, dependent: :destroy
  has_many :forecast_sources,         through: :resorts_forecast_sources

  has_many :favorites, dependent: :destroy
  has_many :users,     through: :favorites

  validates :uid,  presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :lat,  presence: true
  validates :lon,  presence: true

  def coords
    [lat, lon]
  end
end
