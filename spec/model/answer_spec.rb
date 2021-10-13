# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Answerモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { answer.valid? }

    let!(:user) { create(:user) }
    let!(:question) { build(:question, user_id: user.id) }
    let!(:answer) { build(:answer, user_id: user.id, question_id: question.id) }

    context 'bodyカラム' do
      it '空欄でないこと' do
        answer.body = ''
        is_expected.to eq false
      end
    end
  end
end
