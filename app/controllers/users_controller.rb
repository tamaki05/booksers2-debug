class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to books_path, notice: "Welcome! You have signed up successfully."
    else
      render :root_path
    end
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: "You have updated user successfully."
    else
      render :edit
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @users = @user.followings
    render 'follow_user'
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'follower_user'
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
