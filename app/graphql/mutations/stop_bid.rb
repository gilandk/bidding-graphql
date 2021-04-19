module Mutations
  class StopBid < BaseMutation
    # arguments passed to the `resolve` method
    argument :product_id, ID, required: true

    # return type from the mutation
    type Types::ProductType

    def resolve(product_id: nil)
      val = 1
      @product = Product.find(product_id)
      @product.update(stop_bid: val)

      @products = Product.find(product_id)
      @products
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
