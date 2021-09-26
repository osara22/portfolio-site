# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Blogモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { blog.valid? }

    let!(:blog) { create(:blog) }
    let(:blog) { build(:blog) }

    context 'titleカラム' do
      it '空欄でないこと' do
        blog.title = ''
        is_expected.to eq false
      end
      it '255文字以内であること 256文字はNG' do
        blog.title = Faker::Lorem.characters(number: 256)
        is_expected.to eq false
      end
      it '255文字以内であること 255文字はOK' do
        blog.title = Faker::Lorem.characters(number: 255)
        is_expected.to eq true
      end
    end

    context 'bodyカラム' do
      it '空欄でないこと' do
        blog.body = ''
        is_expected.to eq false
      end
    end

    context 'top_imageカラム' do
      it '空欄でないこと' do
        blog.top_image_id = ''
        is_expected.to eq false
      end
    end

    context 'video_urlカラム' do
      it '255文字以内であること 256文字はNG' do
        blog.video_url = Faker::Lorem.characters(number: 256)
        is_expected.to eq false
      end
      it '255文字以内であること 255文字はOK' do
        blog.video_url = Faker::Lorem.characters(number: 255)
        is_expected.to eq true
      end
    end

    context 'twitter_urlカラム' do
      it '255文字以内であること 256文字はNG' do
        blog.twitter_url = Faker::Lorem.characters(number: 256)
        is_expected.to eq false
      end
      it '255文字以内であること 255文字はOK' do
        blog.twitter_url = Faker::Lorem.characters(number: 255)
        is_expected.to eq true
      end
    end
  end
end
