class PostsController < ApplicationController
  def index
    @user = params[:user_id]
    @post = Post.where(author_id: @user)
  end

  def show
    @post_id = params[:id]
    @user = params[:user_id]
    @post = Post.find_by(id: @post_id)
  end
end
