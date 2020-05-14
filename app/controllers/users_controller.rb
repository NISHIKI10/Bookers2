class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_index, only: :edit

  def index
    @users = User.all
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def edit
    @user = User.find(current_user.id) 
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'successfully update!.'
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  private
    def user_params
      params.require(:user).permit(:name, :introduction, :profile_imaged)
    end
    
    def redirect_index
      show
      redirect_to user_path(current_user.id) unless current_user.id == @user.id
    end
end