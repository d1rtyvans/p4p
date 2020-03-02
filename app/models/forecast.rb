class Forecast < ApplicationRecord
  validates :type,    presence: true
  validates :date,    presence: true
  validates :status,  presence: true

  # TODO: Validators/schema for json payload to ensure format of data and
  # common keys are present
  validates :payload, presence: true

  belongs_to :resort

  enum status: %i[
    pending synced error
  ]
end

