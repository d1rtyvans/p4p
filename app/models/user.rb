class User < ApplicationRecord
  # Once I start letting other people test I'll build in a sign up flow...
  # For now just email
  validates :email,  presence: true, uniqueness: { case_sensitive: false }

  has_many :favorites
  has_many :resorts, through: :favorites
end
