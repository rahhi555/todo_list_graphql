# frozen_string_literal: true

module Mutations
  class Login < BaseMutation
    field :user, Types::UserType, null: false
    field :token, String, null: false

    argument :email, String, required: true
    argument :password, String, required: true

    def resolve(email:, password:)
      user = ::User.find_by(email:)
      raise GraphQL::ExecutionError, I18n.t('graphql.error.user.not_find_user') unless user

      raise GraphQL::ExecutionError, I18n.t('graphql.error.user.not_match_password') unless user.authenticate(password)

      { user:, token: user.create_jwt_token }
    end
  end
end
