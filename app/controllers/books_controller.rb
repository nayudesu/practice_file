class BooksController < ApplicationController
  before_action :authenticate_user! #決まったメソッド
  before_action :ensure_correct_user, only: [:edit, :update, :destroy] #ensure_correct_userは自分で作成したメソッド


  def show
    @book = Book.find(params[:id])
    @book_new = Book.new #空のカラムを用意する（投稿フォームの部分てんぷれーと）
    @comment = Comment.new #コメントの空のカラム
  end

  def index
    if params[:latest] #params[:latest]=ビューからの指示を受けるための名前を定義。ビューのlatestと繋がる。
      @books = Book.latest #Book.latest=モデルで記述したlatestと繋がる
    elsif params[:old]
      @books = Book.old
    elsif params[:star_count]
      @books = Book.star_count
    else
      @books = Book.all
    end 
    
    @book_new = Book.new #投稿フォームのため空のカラムが必要
  end
  
  def new
    @book = Book.new
  end 

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :star) #starカラムを保存できるように
  end
  
  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end 
  end 
end
