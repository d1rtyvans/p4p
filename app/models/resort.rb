class Resort < ApplicationRecord
  validates :uid,  presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :lat,  presence: true
  validates :lon,  presence: true

  has_many :forecasts
  has_many :favorites
  has_many :users, through: :favorites

  def coords
    [lat.to_f, lon.to_f]
  end
end
