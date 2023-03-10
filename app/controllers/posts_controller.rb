class PostsController < ApplicationController
  load_and_authorize_resource

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
    user_id = params[:user_id].to_i

    return if current_user.id == user_id

    authorize! :create, @post
  end

  def create
    @post = Post.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0
    @post.author = current_user
    if @post.save
      flash[:notice] = 'Post was successfully created'
      redirect_to users_path
    else
      flash.now[:error] = 'An error has occurred. Post could not be created, Please try again later.'
      render :new
    end
  end

  def destroy
    user = current_user
    @post = Post.find_by(id: params[:id], author_id: params[:user_id])
    @post.likes.destroy_all
    @post.comments.destroy_all

    if @post.destroy
      flash[:notice] = 'Post deleted!'
    else
      flash[:alert] = 'Error! Please try again later.'
    end
    redirect_to user_posts_path(user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
