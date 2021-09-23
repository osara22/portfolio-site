class Public::BlogsController < ApplicationController
  def index

  end

  def show
    @slide_blogs = Blog.limit(5)
    @blog = Blog.find(params[:id])
    @tags = Blog.find(params[:id]).tag_counts_on(:tags)
  end
end
