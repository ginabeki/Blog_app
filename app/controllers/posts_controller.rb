class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    # @user_posts = Post.where(author: @user)
    # @posts = @user.posts.includes(:comments)
    @posts = Post.includes(:author).paginate(page: params[:page], per_page: 3)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find_by(id: params[:id])
    @comments = Comment.where(post_id: @post)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(person_params)

    if @post.save
      redirect_to users_path
    else
      render :new
    end
  end

  def person_params
    params
      .require(:post)
      .permit(:title, :text)
      .merge(author: current_user)
  end
end
