# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :login, mutation: Mutations::Login
    field :user_create, mutation: Mutations::UserCreate
  end
end
