# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe 'shoulda matchers' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to define_enum_for(:status).with_values(todo: 0, doing: 1, done: 2) }
  end

  describe '正常系' do
    let(:user) { create(:user) }

    it 'statusのデフォルト値は0であること' do
      expect do
        user.todos.create!(title: 'test title')
      end.to change { Todo.count }.by(1)

      expect(Todo.last.status).to eq 'todo'
    end
  end
end
