require 'rails_helper'

describe 'loginとsigninの動作確認', type: :system do

  describe 'user新規登録の動作確認' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user_email'
      end
      it 'user_nameフォームが表示される' do
        expect(page).to have_field 'user_name'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user_password'
      end
      it 'password確認フォームが表示される' do
        expect(page).to have_field 'user_password_confirmation'
      end
      it '新規登録ボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
    end

    before do
      visit new_user_registration_path
    end
    context 'sign_up成功の確認' do
      it 'sign_up後のリダイレクト先が、user詳細ページになっている' do
        fill_in 'user[email]', with:  'abcd@example.com'
        fill_in 'user[name]', with: 'namaee'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button '新規登録'

        expect(page).to have_content 'ユーザーページ'
        expect(current_path).to eq '/users/' + User.last.id.to_s
      end
    end
  end

  describe 'userログインページの動作確認' do
    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user_email'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user_password'
      end
      it 'ログインボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
    end

    context 'ログインの動作確認(login_userメソッド)' do
      let(:user) { create(:user) }

      it 'sign_in後のリダイレクト先が、ユーザー詳細ページになっている' do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_on 'ログイン'
        expect(current_path).to eq '/users/' + User.last.id.to_s
      end
    end
  end

  describe 'adminログインページの動作確認' do
    before do
      visit new_admin_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/admins/sign_in'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'admin_email'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'admin_password'
      end
      it 'ログインボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
    end

    context 'ログインの動作確認(login_adminメソッド)' do
      let(:admin) { create(:admin) }

      it 'sign_in後のリダイレクト先が、adminのトップページになっている' do
        visit new_admin_session_path
        fill_in 'admin[email]', with: admin.email
        fill_in 'admin[password]', with: admin.password
        click_on 'ログイン'
        expect(current_path).to eq '/admin'
      end
    end
  end
end
