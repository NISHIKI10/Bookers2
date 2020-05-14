class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_index, only: :edit

  def index
    @books = Book.all
    @book = Book.new
    @book.user_id = current_user.id
    @user = User.find(@book.user.id)
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: 'successfully create!.'
    else
      @books = Book.all
      @book.user_id = current_user.id
      @user = User.find(@book.user.id)
      render :index
    end
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: 'successfully update!.'
    else
      @book_new = Book.new
      @user = @book.user
      flash.now[:notice] = 'error'
      render :show
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      redirect_to books_path
    else
      flash.now[:notice] = 'error'
      render :show
    end
  end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end

    def redirect_index
      show
      redirect_to books_path unless user_signed_in? && current_user.id == @user.id
    end
end