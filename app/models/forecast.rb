class Forecast < ApplicationRecord
  validates :type,    presence: true
  validates :date,    presence: true
  validates :payload, presence: true
  validates :status,  presence: true

  belongs_to :resort

  enum status: %i[
    pending synced error
  ]
end

