module SystemSupport
  def login_admin(admin)
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_on 'ログイン'
  end

  def login_user(user)
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_on 'ログイン'
  end

  def upload_blog(blog, blog_tags)
    visit new_admin_blog_path
    fill_in 'blog_title', with: blog.title
    attach_file 'blog_top_image', "#{Rails.root}/app/assets/images/sample_img.jpg"
    fill_in 'blog[body]', with: blog.body
    fill_in 'blog_video_url', with: 'https://youtu.be/WJzSBLCaKc8'
    fill_in 'blog_twitter_url', with: 'https://twitter.com/hikakin/status/1448923886037336064'
    attach_file 'blog_body_image', "#{Rails.root}/app/assets/images/default_cube.jpg"
    fill_in 'blog_tag_list', with: blog_tags
    click_on '新規登録'
  end

  def upload_question(question)
    visit new_question_path
    fill_in 'question[title]', with: question.title
    fill_in 'question[body]', with: question.body
    attach_file 'question[image]', "#{Rails.root}/app/assets/images/default_cube.jpg"
    click_on '新規登録'
  end

  def upload_answer(answer)
    visit '/questions/' + Question.last.id.to_s + '/answers/new'
    fill_in 'answer[body]', with: answer.body
    click_on '新規登録'
  end
end
