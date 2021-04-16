require 'search_object'
require 'search_object/plugin/graphql'

class Resolvers::BidsSearch < Resolvers::BaseSearchResolver
  # include SearchObject for GraphQL
  include SearchObject.module(:graphql)

  # scope is starting point for search
  scope { Bid.all }

  type types[Types::BidType]

  # inline input type definition for the advanced filter
  class BidFilter < ::Types::BaseInputObject
    argument :OR, [self], required: false
    argument :amount_contains, Integer, required: false
    argument :status_contains, String, required: false
  end

  # when "filter" is passed "apply_filter" would be called to narrow the scope
  option :filter, type: BidFilter, with: :apply_filter
  option :first, type: types.Int, with: :apply_first
  option :skip, type: types.Int, with: :apply_skip

  # apply_filter recursively loops through "OR" branches
  def apply_filter(scope, value)
    branches = normalize_filters(value).reduce { |a, b| a.or(b) }
    scope.merge branches
  end

  def apply_first(scope, value)
    scope.limit(value)
  end

  def apply_skip(scope, value)
    scope.offset(value)
  end

  def normalize_filters(value, branches = [])
    scope = Bid.all

    scope = scope.where('bid_amount = ?', (value[:bid_amount_contains]).to_s) if value[:bid_amount_contains]
    scope = scope.where('status LIKE ?', "%#{value[:status_contains]}%") if value[:status_contains]

    branches << scope

    value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) } if value[:OR].present?

    branches
  end
end
