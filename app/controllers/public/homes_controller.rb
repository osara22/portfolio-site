class Public::HomesController < ApplicationController
  def top
    @slide_blogs = Blog.last(4).reverse
    @blogs = Blog.all.last(4).reverse
  end
end
