module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :me, resolver: Queries::Me
    field :all_products, resolver: Resolvers::ProductsSearch
    field :all_users, resolver: Resolvers::UsersSearch
    field :all_bids, resolver: Resolvers::BidsSearch
  end
end
