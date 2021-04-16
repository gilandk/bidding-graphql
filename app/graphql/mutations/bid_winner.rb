module Mutations
  class BidWinner < BaseMutation
    # arguments passed to the `resolve` method
    argument :bid_id, ID, required: true

    # return type from the mutation
    type Types::BidType

    def resolve(bid_id: nil)
      val = 1
      @bid = Bid.find(bid_id)
      @bid.update(status: val)

      @bids = Bid.find(bid_id)
      @bids
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
