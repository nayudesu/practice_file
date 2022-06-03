class BooksController < ApplicationController
  
  def new
    @book = Book.new
  end
  
  def create #newとcreateはセット
    @book = Book.new(book_params) #createは必ずストロングパラメーターをかく
    @book.user_id = current_user.id #ユーザーを確認(_注意)
    @book.save
    redirect_to book_path(@book)
  end 

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end 
  
  private
  
  def book_params
    params.require(:book).permit(:title,:body)
  end 
end
