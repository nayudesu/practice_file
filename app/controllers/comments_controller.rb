class CommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id]) #(params[:id])ではダメなのか？
    @comment = current_user.comments.new(comment_params) #comment_paramsはストロングパラメーター
    @comment.book_id = @book.id
    @comment.save
    #redirect_to request.referer #request.referer前の画面に遷移する
  end 
  
  def destroy
    @book = Book.find(params[:book_id]) #(params[:id])ではダメなのか？
    @comment = Comment.find_by(params[:id])
    @comment.destroy
    #redirect_to request.referer #request.referer前の画面に遷移する
  end 
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment)
  end 
end
