class ApplicationController < ActionController::Base
  # アクションが行われる前に、新規登録で以下の内容を用いることを許可する
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  # ログイン後のリダイレクト処理
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_path
    when User
      root_path
    end
  end

  # ログアウト後の処理
  def after_sign_out_path_for(_resource)
    root_path
  end

  # アドミンでないときにアクセスしようとしたときの処理
  def admin_not_signin
    redirect_to root_path unless admin_signed_in?
  end

  # ログインしてないのにアクセスしようとしたときの処理
  def user_not_signin
    redirect_to new_user_session_path unless user_signed_in?
  end

  # 自分が作った記事に回答しようとしたときの処理
  def current_user_signin
    redirect_to root_path if current_user.id == Question.find(params[:id]).user_id
  end
end
