# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User関連のMutation', type: :request do
  describe 'user_create Mutation' do
    let(:new_user) { build(:user) }

    it '属性が正しい場合、新たにuserを作成できること' do
      query = <<~QUERY
        mutation {
          userCreate(input: {
            userInput: {
              email: "#{new_user.email}",
              password: "#{new_user.password}",
              passwordConfirmation: "#{new_user.password_confirmation}"
            }
          })
          {
            token
            user {
              id
              email
            }
          }
        }
      QUERY

      expect do
        post graphql_path, params: { query: }
      end.to change { User.count }.by(1)
      token = response.parsed_body['data']['userCreate']['token']
      user = response.parsed_body['data']['userCreate']['user']
      expect(JWT.decode(token, Rails.application.credentials.secret_key_base)[0]['id']).to eq user['id'].to_i
      expect(user['email']).to eq new_user.email
    end
  end
end
