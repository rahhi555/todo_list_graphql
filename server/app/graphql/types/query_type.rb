# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :current_user, UserType, description: '現在のユーザーを取得する'
    def current_user
      require_authorized
      context[:current_user]
    end

    private

    def require_authorized
      raise GraphQL::ExecutionError, I18n.t('graphql.error.require_login') unless context[:current_user].present?
    end
  end
end
