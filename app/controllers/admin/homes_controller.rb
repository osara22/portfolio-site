class Admin::HomesController < ApplicationController
  # 管理者アカウントでなければroot_pathにリダイレクトする
  before_action :admin_not_signin

  def top

  end
end
