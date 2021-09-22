class Public::HomesController < ApplicationController
  def top
    @slide_blogs = Blog.limit(5)
    @blogs = Blog.all.last(4).reverse
  end
end
