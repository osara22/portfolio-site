class Admin::BlogsController < ApplicationController
  # 管理者アカウントでなければroot_pathにリダイレクトする
  before_action :admin_not_signin

  def index
    @tags = Blog.tag_counts_on(:tags)
    @search_word = params[:search_word]
    if params[:tag]
      @blogs = Blog.tagged_with(params[:tag])
    elsif params[:search_word]
      @blogs = Blog.where("title Like ?", "%" + @search_word + "%")
    else
      @blogs = Blog.all
    end
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
    @tags = Blog.find(params[:id]).tag_counts_on(:tags)
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
    params.require(:blog).permit(:title, :body, :top_image, :body_image, :video_url, :tag_list)
  end

end
