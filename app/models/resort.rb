class Resort < ApplicationRecord
  validates :uid,  presence: true, uniqueness: true
  validates :name, presence: true
  validates :lat,  presence: true
  validates :lon,  presence: true
end
