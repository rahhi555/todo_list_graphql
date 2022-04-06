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

  describe 'login Mutation' do
    let!(:user) { create(:user) }
    it '属性が正しい場合、tokenとuserが返ってくること' do
      query = <<~QUERY
        mutation {
          login(input: {
            email: "#{user.email}",
            password: "password"
          }) {
            token
            user {
              id
            }
          }
        }
      QUERY

      post graphql_path, params: { query: }

      login = response.parsed_body['data']['login']
      expect(login['token']).to eq user.create_jwt_token
      expect(login['user']['id']).to eq user.id.to_s
    end

    it 'emailが誤っている場合、エラーが返ってくること' do
      query = <<~QUERY
        mutation {
          login(input: {
            email: "hoge@errors.com",
            password: "password"
          }) {
            token
            user {
              id
            }
          }
        }
      QUERY

      post graphql_path, params: { query: }

      message = response.parsed_body['errors'][0]['message']
      expect(message).to eq I18n.t('graphql.error.user.not_find_user')
    end

    it 'passwordが誤っている場合、エラーが返ってくること' do
      query = <<~QUERY
        mutation {
          login(input: {
            email: "#{user.email}",
            password: "bad_password"
          }) {
            token
            user {
              id
            }
          }
        }
      QUERY

      post graphql_path, params: { query: }

      message = response.parsed_body['errors'][0]['message']
      expect(message).to eq I18n.t('graphql.error.user.not_match_password')
    end
  end
end
