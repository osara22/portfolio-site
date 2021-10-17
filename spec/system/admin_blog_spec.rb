require 'rails_helper'
include SystemSupport

describe 'adminのblog機能の動作確認', type: :system do
  before do
    admin = create(:admin)
    login_admin(admin)
  end
  # 投稿に使うデータの作成

  let(:blog) { build(:blog) }

  describe '投稿機能の動作確認' do
    context 'トップページのボタンから投稿画面に行けるか' do
      it 'トップページに必要なリンクがあるか' do
        expect(page).to have_link 'ブログ投稿'
        expect(page).to have_link 'ブログ一覧'
      end
      it 'ボタンからの遷移先が正しいか' do
        click_on 'ブログ投稿'
        expect(current_path).to eq '/admin/blogs/new'
      end
    end

    context '投稿画面の表示内容の確認' do
      before do
        visit new_admin_blog_path
      end

      it 'titleフォームが表示される' do
        expect(page).to have_field 'blog_title'
      end
      it 'top_imageフォームが表示される' do
        expect(page).to have_field 'blog_top_image'
      end
      it 'bodyフォームが表示される' do
        expect(page).to have_field 'blog_body'
      end
      it 'video_urlフォームが表示される' do
        expect(page).to have_field 'blog_video_url'
      end
      it 'twitter_urlフォームが表示される' do
        expect(page).to have_field 'blog_twitter_url'
      end
      it 'body_imageフォームが表示される' do
        expect(page).to have_field 'blog_body_image'
      end
      it 'tag_listフォームが表示される' do
        expect(page).to have_field 'blog_tag_list'
      end
      it '新規登録ボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
    end

    context '投稿機能の動作確認' do
      before do
        upload_blog(blog, 'テスト,test')
      end

      it '投稿後のリダイレクト先がブログ詳細ページになっている' do
        expect(current_path).to eq '/blogs/' + Blog.last.id.to_s
      end
      it '投稿したtitleが表示されているか' do
        expect(page).to have_content blog.title
      end
      it '投稿したtagが表示されているか' do
        expect(page).to have_link 'テスト'
        expect(page).to have_link 'test'
      end
      it '投稿したtop_imageが表示されているか' do
        expect(page).to have_selector("img[src$='top_image.jpg']")
      end
      it '投稿したbodyが表示されているか' do
        expect(page).to have_content blog.body
      end
      it '投稿したbody_imageが表示されているか' do
        expect(page).to have_selector("img[src$='body_image.jpg']")
      end
      it '投稿したtwitterが表示されているか' do
        expect(page).to have_link href: 'https://twitter.com/hikakin/status/1448923886037336064'
      end
    end
  end

  describe '編集機能の動作確認' do
    before do
      upload_blog(blog, 'テスト,test')
    end

    context '一覧画面から編集画面に行けるか' do
      before do
        visit admin_blogs_path
      end

      it '一覧画面に投稿したブログがあるか' do
        expect(page).to have_link blog.title
      end
      it '編集ボタンからの遷移先が正しいか' do
        click_link '編集', href: "/admin/blogs/#{Blog.last.id}/edit"
        expect(current_path).to eq "/admin/blogs/#{Blog.last.id}/edit"
      end
    end

    context '編集画面の表示内容の確認' do
      before do
        visit "/admin/blogs/#{Blog.last.id}/edit"
      end

      it 'titleフォームが表示される' do
        expect(page).to have_field 'blog_title'
      end
      it 'top_imageフォームが表示される' do
        expect(page).to have_field 'blog_top_image'
      end
      it 'bodyフォームが表示される' do
        expect(page).to have_field 'blog_body'
      end
      it 'video_urlフォームが表示される' do
        expect(page).to have_field 'blog_video_url'
      end
      it 'twitter_urlフォームが表示される' do
        expect(page).to have_field 'blog_twitter_url'
      end
      it 'body_imageフォームが表示される' do
        expect(page).to have_field 'blog_body_image'
      end
      it 'tag_listフォームが表示される' do
        expect(page).to have_field 'blog_tag_list'
      end
      it '保存ボタンが表示される' do
        expect(page).to have_button '編集を保存する'
      end
    end

    context '情報の反映確認' do
      before do
        visit "/admin/blogs/#{Blog.last.id}/edit"
      end

      it '編集した情報が登録されているか' do
        fill_in 'blog_title', with: blog.title + 'test'
        fill_in 'blog_body', with: blog.body + 'test'
        fill_in 'blog_tag_list', with: 'テスト, test, test2'
        click_on '編集を保存する'
        expect(page).to have_content blog.title + 'test'
        expect(page).to have_content blog.body + 'test'
        expect(page).to have_link 'test2'
      end
    end
  end
end
