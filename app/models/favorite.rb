class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :resort

  validates :user,   presence: true
  validates :resort, presence: true
end
