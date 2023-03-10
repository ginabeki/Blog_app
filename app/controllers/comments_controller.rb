class CommentsController < ApplicationController
  load_and_authorize_resource

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      flash[:notice] = 'Comment Added successfully'
      redirect_to user_posts_path(current_user)
    else
      flash[:error] = 'An error has occurred. Comment could not be created, Please try again later.'
      # render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    author = @comment.post.author
    post = @comment.destroy
    if @comment.destroy
      flash[:notice] = 'Comment deleted!'
    else
      flash[:alert] = 'Error! Please try again later.'
    end
    redirect_to user_post_url(author, post)
  end

  def comment_params
    params
      .require(:comment)
      .permit(:text)
      .merge(author: current_user, post: current_user.posts.find(params[:post_id]))
  end
end
