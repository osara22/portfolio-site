require 'rails_helper'

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
    let(:blog) { build(:blog) }

    before do
      admin = create(:admin)
      login_admin(admin)
    end

    it '投稿後のリダイレクト先が、blog詳細ページになっている' do
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

  context 'question投稿の動作確認(upload_questionメソッド)' do
    let(:question) { build(:question) }

    before do
      user = create(:user)
      login_user(user)
    end

    it '投稿後の情報が正しいか' do
      visit new_question_path
      fill_in 'question[title]', with: question.title
      fill_in 'question[body]', with: question.body
      attach_file 'question[image]', "#{Rails.root}/app/assets/images/default_cube.jpg"
      click_on '新規登録'
      expect(current_path).to eq '/questions/' + Question.last.id.to_s
      expect(page).to have_content question.title
      expect(page).to have_content question.body
      expect(page).to have_selector("img[src$='image.jpg']")
    end
  end

  context 'answer投稿の動作確認(upload_answerメソッド)' do
    let(:question) { build(:question) }
    let(:answer) { build(:answer) }

    before do
      user_question = create(:user)
      user_answer = create(:user)
      login_user(user_question)
      upload_question(question)
      click_on 'ログアウト'
      login_user(user_answer)
    end

    it '投稿後の情報が正しいか' do
      visit '/questions/1/answers/new'
      fill_in 'answer[body]', with: answer.body
      click_on '新規登録'
      expect(current_path).to eq '/questions/1'
      expect(page).to have_content answer.body
    end
  end
end
