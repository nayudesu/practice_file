class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id) #book_id:カラムに#3のidを入れる
    #いいねした人のuser_idが自動でカラムに保存される
    favorite.save
    #redirect_to request.referer #request.referer前の画面に遷移する =非同期のため削除
    render 'favorite'
  end 
  
  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    #find_byは検索バーに表示されないidを探す (いいねのidなど)
    favorite.destroy
    #redirect_to request.referer #request.referer前の画面に遷移する =非同期のため削除
    render 'favorite'
  end
end
