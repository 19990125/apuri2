class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, only: [:edit, :update]

  def top
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    unless user_signed_in?
      redirect_to  users_path
    end
  end

  def create
    user = User.new(user_params)
    @user.user_id = current_user.id
    if user.save
      flash[:notice] ='Welcome! You have signed up successfully.'
    redirect_to current_user(user.id)
    else
      render:new
    end
  end

  def new
    @users = User.all
    @user = User.new
  end

  def update
    @users = User.all
    if @user.update(user_params)
      flash[:success] = "You have updated user successfully."
      redirect_to user_path(current_user.id)
    else
      render:edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name,:introduction,:email,:password,:user_id,:profile_image)
  end

  def ensure_current_user
     @user = User.find(params[:id])
  if current_user.id != params[:id].to_i
    redirect_to user_path(current_user)
  end
  end
end