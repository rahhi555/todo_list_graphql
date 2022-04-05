# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User関連のQuery', type: :request do
  describe 'current_user Query' do
    let!(:user) { create(:user) }
    query = <<~QUERY
      {
        currentUser {
          id
          email
        }
      }
    QUERY

    it 'ヘッダーにトークンが含まれている場合、現在のユーザーを取得できること' do
      post graphql_path, params: { query: }, headers: { Authorization: "Bearer #{user.create_jwt_token}" }
      current_user = response.parsed_body['data']['currentUser']
      expect(current_user['id']).to eq user.id.to_s
      expect(current_user['email']).to eq user.email
    end
  end
end
