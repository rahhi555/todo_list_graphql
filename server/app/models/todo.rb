# frozen_string_literal: true

class Todo < ApplicationRecord
  belongs_to :user

  attribute :status, :integer, default: 0

  enum status: { todo: 0, doing: 1, done: 2 }

  validates :title, presence: true
  validates :status, presence: true
end
