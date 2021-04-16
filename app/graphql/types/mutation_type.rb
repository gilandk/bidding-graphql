module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :create_product, mutation: Mutations::CreateProduct
    field :create_bid, mutation: Mutations::CreateBid
    field :create_user, mutation: Mutations::CreateUser
    field :sign_in, mutation: Mutations::SignIn
    field :stop_bid, mutation: Mutations::StopBid
    field :bid_winner, mutation: Mutations::BidWinner
  end
end
