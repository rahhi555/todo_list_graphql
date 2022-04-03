# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'shoulda mathcers' do
    it { is_expected.to have_secure_password }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:email).is_at_most(255) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
    it do
      FactoryBot.create(:user)
      is_expected.to validate_uniqueness_of(:email).case_insensitive
    end
  end
end
