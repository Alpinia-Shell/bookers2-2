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
    @book_new = Book.new
    @user = @book.user
  end

  def edit 
    login_user_confirmation
    @book = Book.find(params[:id])
  end

  def update
    login_user_confirmation
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book)
    else
    render :edit
    end
  end 

  def destroy
    Book.find(params[:id]).destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def login_user_confirmation
    book = Book.find(params[:id])
    unless book.user == current_user 
    redirect_to books_path
    end
  end

end
