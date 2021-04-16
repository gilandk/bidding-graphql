module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: false
    field :lowest_bid, Integer, null: false
    field :starting_bid, Integer, null: false
    field :expire_bid, GraphQL::Types::ISO8601Date, null: false
    field :stop_bid, Boolean, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
