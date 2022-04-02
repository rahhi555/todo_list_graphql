# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'shoulda mathcers' do
    it { is_expected.to have_secure_password }
  end
end
