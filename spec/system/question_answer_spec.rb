require 'rails_helper'
include SystemSupport

describe 'Q&A機能の動作確認', type: :system do
  # テストに使うデータの作成
  let(:user_question) { create(:user) }
  let(:user_answer) { create(:user) }
  let(:question) { build(:question) }
  let(:answer) { build(:answer) }

  describe '質問投稿機能の確認' do
    before do
      login_user(user_question)
      visit questions_path
    end

    context '投稿画面表示の確認' do
      it 'Q&Aトップページから投稿画面へ行けるか' do
        click_on '質問する'
        expect(current_path).to eq '/questions/new'
      end
      it '投稿画面に必要な機能が揃っているか' do
        visit '/questions/new'
        expect(page).to have_field 'question[title]'
        expect(page).to have_field 'question[body]'
        expect(page).to have_field 'question[image]'
        expect(page).to have_button '新規登録'
      end
    end

    context '投稿機能の確認' do
      before do
        upload_question(question)
      end

      it '投稿後のリダイレクト先が質問詳細ページになっているか' do
        expect(current_path).to eq '/questions/' + Question.last.id.to_s
      end
      it '投稿画面に投稿したデータが表示されているか' do
        expect(page).to have_content question.title
        expect(page).to have_content question.body
        expect(page).to have_selector("img[src$='image.jpg']")
      end
      it '表示してはいけないデータが表示されていないか' do
        expect(page).not_to have_button '回答する'
        expect(page).not_to have_button 'ベストアンサーを選ぶ'
      end
    end
  end

  describe '回答投稿機能の確認' do
    # 質問投稿をして、回答するuserに変更
    before do
      login_user(user_question)
      upload_question(question)
      click_on 'ログアウト'
      login_user(user_answer)
      visit '/questions/' + Question.last.id.to_s
    end

    context '投稿画面表示の確認' do
      it '質問詳細ページから投稿画面へ行けるか' do
        click_on '回答する'
        expect(current_path).to eq '/questions/' + Question.last.id.to_s + '/answers/new'
      end
      it '投稿画面に必要な機能が揃っているか' do
        visit '/questions/' + Question.last.id.to_s + '/answers/new'
        expect(page).to have_field 'answer[body]'
        expect(page).to have_button '新規登録'
      end
    end

    context '投稿機能の確認' do
      before do
        upload_answer(answer)
      end

      it '投稿後のリダイレクト先が質問詳細ページになっているか' do
        expect(current_path).to eq '/questions/' + Question.last.id.to_s
      end
      it '投稿画面に投稿したデータが表示されているか' do
        expect(page).to have_content answer.body
      end
      it '表示してはいけないデータが表示されていないか' do
        expect(page).not_to have_button '回答する'
        expect(page).not_to have_button 'ベストアンサーを選ぶ'
      end
    end
  end

  describe 'ベストアンサー投稿機能の確認' do
    # 質問投稿をして、user変更して回答し、質問したユーザーに戻している
    before do
      login_user(user_question)
      upload_question(question)
      click_on 'ログアウト'
      login_user(user_answer)
      upload_answer(answer)
      click_on 'ログアウト'
      login_user(user_question)
      visit '/questions/' + Question.last.id.to_s
    end

    context '投稿画面表示の確認' do
      it '質問詳細ページから投稿画面へ行けるか' do
        click_on 'ベストアンサーを選ぶ'
        expect(current_path).to eq '/questions/' + Question.last.id.to_s + '/best_select'
      end
      it '投稿画面に必要な機能が揃っているか' do
        visit '/questions/' + Question.last.id.to_s + '/best_select'
        expect(page).to have_field 'question[best_answer_id]'
        expect(page).to have_field 'question[thank]'
        expect(page).to have_button '確定'
      end
    end

    context '投稿機能の確認' do
      before do
        click_on 'ベストアンサーを選ぶ'
        choose 'question_best_answer_id_' + Answer.last.id.to_s
        fill_in 'question[thank]', with: 'thanks'
        click_on '確定'
      end

      it '投稿後のリダイレクト先が質問詳細ページになっているか' do
        expect(current_path).to eq '/questions/' + Question.last.id.to_s
      end
      it '投稿画面に投稿したデータが表示されているか' do
        expect(page).to have_content 'thanks'
      end
      it '表示してはいけないデータが表示されていないか' do
        expect(page).not_to have_button '回答する'
        expect(page).not_to have_button 'ベストアンサーを選ぶ'
      end
    end
  end
end
