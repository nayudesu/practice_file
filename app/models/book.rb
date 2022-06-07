class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  
  #いいねの有無を調べるメソッド（自分で決めてよい）
  def favorited_by?(user) #引数にuser
    favorites.exists?(user_id: user.id)
  #existsはFavoritesテーブル内にuser.idが存在（exists?）するかどうか
  end 
  
  #検索機能
  def self.looks(search, word) #self
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
    #whereメソッドを使いデータベースから該当データを取得
  end
end
