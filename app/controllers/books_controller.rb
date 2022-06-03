class BooksController < ApplicationController
  
  def new
    @book = Book.new
  end
  
  def create #newとcreateはセット
    @book = Book.new(book_params) #createは必ずストロングパラメーターをかく
    @book.user_id = current_user.id #ユーザーを確認(_注意)
    if @book.save
    redirect_to book_path(@book)
    else
    @books = Book.all #indexに記載されてあるインスタンス変数を指定すること
    @user = current_user
    render :index
    end 
  end 

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end
  
  def edit
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to  books_path #一覧画面に戻る
    end
  end
  
  def update #editとセット
    @book = Book.find(params[:id])
    if @book.update(book_params) #ストロングパラメーター
      redirect_to book_path
    else
      render :edit
    end
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
