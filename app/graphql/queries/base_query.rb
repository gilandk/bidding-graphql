module Queries
  class BaseQuery < GraphQL::Schema::Resolver
    # The method authenticates the token
    def authenticate_user
      raise GraphQL::ExecutionError, 'You must be logged in to perform this action' unless context[:current_user]
    end
  end
end
