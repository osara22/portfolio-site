require 'rails_helper'
include SystemSupport

describe 'system_supportの動作確認', type: :system do
  context 'userログインの動作確認(login_userメソッド)' do
    let(:user) { create(:user) }
    it 'sign_in後のリダイレクト先が、ユーザー詳細ページになっている' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_on 'ログイン'

      expect(current_path).to eq '/users/' + User.last.id.to_s
    end
  end

  context 'adminログインの動作確認(login_adminメソッド)' do
    let(:admin) { create(:admin) }
    it 'sign_in後のリダイレクト先が、adminのトップページになっている' do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_on 'ログイン'

      expect(current_path).to eq '/admin'
    end
  end

  context 'blog投稿の動作確認(upload_blogメソッド)' do
    before do
      admin = create(:admin)
      login_admin(admin)
    end
    let(:blog) { build(:blog) }
    it '投稿後のリダイレクト先が、blog詳細ページになっているか' do
      visit new_admin_blog_path

      fill_in 'blog_title', with: blog.title
      attach_file 'blog_top_image', "#{Rails.root}/app/assets/images/sample_img.jpg"
      fill_in 'blog[body]', with: blog.body
      fill_in 'blog_video_url', with: 'https://youtu.be/WJzSBLCaKc8'
      fill_in 'blog_twitter_url', with: 'https://twitter.com/hikakin/status/1448923886037336064'
      attach_file 'blog_body_image', "#{Rails.root}/app/assets/images/default_cube.jpg"
      fill_in 'blog_tag_list', with: 'テスト, test'
      click_on '新規登録'

      expect(current_path).to eq '/blogs/' + Blog.last.id.to_s
    end
  end
end
