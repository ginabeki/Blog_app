class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def show
    @user = User.find_by(id: params[:id]) || 'There is no user'
  end
end
