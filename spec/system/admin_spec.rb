require 'rails_helper'

describe 'system_supportがちゃんと動くかテスト', type: :system do

  describe '会員新規登録できるかテスト' do
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
      it 'Log inボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
    end

   before do
     visit new_user_registration_path
   end
    context 'sign_up成功のテスト' do
      it 'sign_up後のリダイレクト先が、root_pathになっている' do
        fill_in 'user[email]', with:  'abcd@example.com'
        fill_in 'user[name]', with: 'namaee'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button '新規登録'

        expect(page).to have_content '新着記事'
        expect(page).to eq root_path
      end
    end
  end
end
