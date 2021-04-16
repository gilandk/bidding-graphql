require 'search_object'
require 'search_object/plugin/graphql'

class Resolvers::ProductsSearch < Resolvers::BaseSearchResolver
  # include SearchObject for GraphQL
  include SearchObject.module(:graphql)

  # scope is starting point for search
  scope { Product.all }

  type types[Types::ProductType]

  # inline input type definition for the advanced filter
  class ProductFilter < ::Types::BaseInputObject
    argument :OR, [self], required: false
    argument :name_contains, String, required: false
    argument :description_contains, String, required: false
    argument :lowest_bid_contains, String, required: false
    argument :starting_bid_contains, String, required: false
    argument :expire_bid, GraphQL::Types::ISO8601Date, required: false
  end

  # when "filter" is passed "apply_filter" would be called to narrow the scope
  option :filter, type: ProductFilter, with: :apply_filter
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
    scope = Product.all

    scope = scope.where('name LIKE ?', "%#{value[:name_contains]}%") if value[:name_contains]
    scope = scope.where('description LIKE ?', "%#{value[:description_contains]}%") if value[:description_contains]
    scope = scope.where('lowest_bid = ?', (value[:lowest_bid_contains]).to_s) if value[:lowest_bid_contains]
    scope = scope.where('starting_bid = ?', (value[:starting_bid_contains]).to_s) if value[:starting_bid_contains]
    scope = scope.where('expire_bid LIKE ?', "%#{value[:expire_bid_contains]}%") if value[:expire_bid_contains]

    branches << scope

    value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) } if value[:OR].present?

    branches
  end
end
