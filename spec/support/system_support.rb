module SystemSupport
  def login_admin(admin)
    visit new_admin_session_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_on 'ログイン'
  end


end