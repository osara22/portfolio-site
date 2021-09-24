class Public::HomesController < ApplicationController
  def top
    @slide_blogs = Blog.last(4).reverse
    @tags = Blog.tags_on(:tags)
    if params[:tag]
      @tag = params[:tag]
      @blogs = Blog.tagged_with(params[:tag])
    elsif params[:search_word]
      @search_word = params[:search_word]
      @blogs = Blog.where("title Like ?", "%" + @search_word + "%")
    else
      @blogs = Blog.all
    end
  end
end
