class UsersController < ApplicationController
  def index
    @users = User.all
    @user =  current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    login_user_confirmation
    @user = User.find(params[:id])
  end

  def update
    login_user_confirmation
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "You have created book successfully."
    redirect_to user_path(@user)
    else
    render :edit
    end
  end
  private

  def user_params
  params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def login_user_confirmation
    user = User.find(params[:id])
    unless user == current_user
    redirect_to user_path(current_user)
    end
  end
end
