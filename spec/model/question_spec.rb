# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Questionモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { question.valid? }

    let!(:user) { create(:user) }
    let(:question) { build(:question, user_id: user.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        question.title = ''
        is_expected.to eq false
      end
      it '255文字以内であること 256文字はNG' do
        question.title = Faker::Lorem.characters(number: 256)
        is_expected.to eq false
      end
      it '255文字以内であること 255文字はOK' do
        question.title = Faker::Lorem.characters(number: 255)
        is_expected.to eq true
      end
    end

    context 'bodyカラム' do
      it '空欄でないこと' do
        question.title = ''
        is_expected.to eq false
      end
    end
  end
end
