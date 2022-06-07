class SearchsController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @range = params[:range] #rangeの中からとってくる
    @word = params[:word] #
    @search = params[:search] #
    
    if @range == "User"
      @users = User.looks(@search, @word) #検索方法params[:search]と、検索ワードparams[:word]を参照してデータを検索＝looks
    else
      @books = Book.looks(@search, @word) 
    end 
  end 
end
