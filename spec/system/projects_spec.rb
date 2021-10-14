require 'rails_helper'
include SystemSupport

# RSpec.describe "アドミンのシステムスペック", type: :system do
#   before  do
#     @request.env['devise.mapping'] = Devise.mappings[:admin]
#   end

#   context 'アドミンページにアクセスできるか' do
#     it 'アドミンページにアクセス' do
#       @admin = create(:admin)
#       visit new_admin_session_path
#       fill_in 'admin_email', with: 'admin@example.com'
#       fill_in 'admin_password', with: 'admin_password'

#       click_button 'admin_login'
#       puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
#       puts current_path
#       puts page.body
#       puts @admin.inspect

#       expect(current_path).to eq admin_path
#     end
#   end

# end

RSpec.describe "Admin" do
  describe 'Log in/out' do
    let(:user) { build(:user) }


    it "Log in" do
      user = create(:user)
       @request.env["devise.mapping"] = Devise.mappings[:user]
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'password'

      click_button 'ログイン'
      # after login succeeds

      expect(current_path).to eq root_path
    end
  end
end