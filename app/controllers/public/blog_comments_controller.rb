class Public::BlogCommentsController < ApplicationController
  def create
    blog = Blog.find(params[:blog_id])
    comment = BlogComment.new(blog_comment_params)
    comment.blog_id = blog.id
    comment.save
    @blog = Blog.find(params[:blog_id])
    @blog_comment = BlogComment.new
  end

  def destroy
    BlogComment.find_by(id: params[:id], blog_id: params[:blog_id]).destroy
    @blog = Blog.find(params[:blog_id])
    @blog_comment = BlogComment.new
  end

  private
  def blog_comment_params
    params.require(:blog_comment).permit(:comment, :name)
  end
end
