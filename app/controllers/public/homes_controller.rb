class Public::HomesController < ApplicationController
  def top
    @slide_blogs = Blog.order('impressions_count DESC').take(5)
    @tags = Blog.tags_on(:tags)
    if params[:tag]
      @tag = params[:tag]
      @blogs = Blog.tagged_with(params[:tag]).page(params[:page]).per(8)
    elsif params[:search_word]
      @search_word = params[:search_word]
      blogs = Blog.where('title Like ?', "%#{@search_word}%")
      @blogs = blogs.page(params[:page]).per(8)
    else
      @blogs = Blog.all.page(params[:page]).per(8)
    end
  end
end
