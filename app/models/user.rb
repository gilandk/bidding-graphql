class User < ApplicationRecord
  has_many :bids

  has_secure_password

  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true
end
