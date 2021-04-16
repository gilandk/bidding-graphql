module Mutations
  class CreateBid < BaseMutation
    argument :product_id, ID, required: false
    argument :bid_amount, Integer, required: false

    type Types::BidType

    def resolve(product_id: nil, bid_amount: nil)
      Bid.create!(
        product: Product.find(product_id),
        user: context[:current_user],
        bid_amount: bid_amount
      )
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
