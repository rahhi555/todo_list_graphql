# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "test#{i}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
