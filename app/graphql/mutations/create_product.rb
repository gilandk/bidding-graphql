module Mutations
  class CreateProduct < BaseMutation
    # arguments passed to the `resolve` method
    argument :name, String, required: true
    argument :description, String, required: true
    argument :lowest_bid, Integer, required: true
    argument :starting_bid, Integer, required: true
    argument :expire_bid, GraphQL::Types::ISO8601Date, required: true

    # return type from the mutation
    type Types::ProductType

    def resolve(name: nil, description: nil, lowest_bid: nil, starting_bid: nil, expire_bid: nil)
      Product.create!(
        name: name,
        description: description,
        lowest_bid: lowest_bid,
        starting_bid: starting_bid,
        expire_bid: expire_bid
      )
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
