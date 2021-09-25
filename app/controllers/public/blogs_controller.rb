class Public::BlogsController < ApplicationController

  def show
    @slide_blogs = Blog.order('impressions_count DESC').take(5)
    @blog = Blog.find(params[:id])
    @blog_comment = BlogComment.new
    @blog_tags = Blog.find(params[:id]).tag_counts_on(:tags)
    @tags = Blog.tags_on(:tags)
    impressionist(@blog, nil, unique: [:request_hash])
  end

end
