class BooksController < ApplicationController
  def create
    @book = current_user.books.new(book_params)
   if @book.save
    flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book)
   else
    @books = Book.all
    @user = current_user
    render :index
   end
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit 
    @book = Book.find(params[:id])
  end

  def destroy
    Book.find(params[:id]).destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
