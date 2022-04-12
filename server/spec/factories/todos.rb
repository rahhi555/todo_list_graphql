# frozen_string_literal: true

FactoryBot.define do
  factory :todo do
    title { 'Todo Title' }
    status { 0 }
    user
  end
end
