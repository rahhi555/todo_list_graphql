# frozen_string_literal: true

module Mutations
  class UserCreate < BaseMutation
    description I18n.t('graphql.description.mutations.create', item: User.model_name.human)

    field :user, Types::UserType, null: false
    field :token, String, null: false

    argument :user_input, Types::UserInputType, required: true

    def resolve(user_input:)
      user = ::User.new(**user_input)
      unless user.save
        raise GraphQL::ExecutionError.new I18n.t('graphql.error.created', item: User.model_name.human),
                                          extensions: user.errors.to_hash
      end

      { user:, token: user.create_jwt_token }
    end
  end
end
