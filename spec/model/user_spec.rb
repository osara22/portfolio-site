# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let!(:user) { create(:user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること　1文字はNG' do
        user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること　2文字はOK' do
        user.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '20文字以下であること　20文字はOK' do
        user.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること　21文字はNG' do
        user.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context 'emailカラム' do
      it '空欄でないこと' do
        user.email = ''
        is_expected.to eq false
      end
    end

    context 'introductionカラム' do
      it '255文字以内であること 256文字はNG' do
        user.introduction = Faker::Lorem.characters(number: 256)
        is_expected.to eq false
      end
      it '255文字以内であること 255文字はOK' do
        user.introduction = Faker::Lorem.characters(number: 255)
        is_expected.to eq true
      end
    end
  end
end
