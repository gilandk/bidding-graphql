class Bid < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :product, validate: true
end
