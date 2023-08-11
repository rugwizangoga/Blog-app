class PostsController < ApplicationController
  def index
    @user_id = params[:user_id]
    @user = User.includes(posts: :comments).find(@user_id)
    @all_posts = @user.posts
  end

  def show
    @post = Post.includes(:author, comments: :author).find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to user_post_path(current_user, @post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
