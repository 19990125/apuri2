class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, only: [:edit, :update]

  def new
    @book = Book.new
    @books = Book.all
  end

  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] ='You have created book successfully.'
    redirect_to book_path(@book.id)
    else
    @user = current_user
    render:index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @bookn = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @books = Book.all
    @book.user_id = current_user.id
    if @book.update(book_params)
      flash[:notice] ='You have updated book successfully.'
    redirect_to book_path(@book.id)
    else
    render:edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

    private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_current_user
  @book = Book.find(params[:id])
  if current_user.id != @book.user_id
    flash[:notice]="権限がありません"
    redirect_to books_path
  end
  end
end
