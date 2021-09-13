class Admin::BlogsController < ApplicationController
  # 管理者アカウントでなければroot_pathにリダイレクトする
  before_action :admin_not_signin

  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to admin_blog_path(@blog.id)
    else
      render :new
    end
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to admin_blog_path(@blog.id)
    else
      render :edit
    end
  end

  # 投稿データのストロングパラメータ
  private

  def blog_params
    params.require(:blog).permit(:title, :body, :top_image, :body_image,:video_url)
  end

end
