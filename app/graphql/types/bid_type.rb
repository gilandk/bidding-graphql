module Types
  class BidType < Types::BaseObject
    field :id, ID, null: false
    field :user, Types::UserType, null: false
    field :product, Types::ProductType, null: false
    field :bid_amount, Integer, null: false
    field :status, Boolean, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
