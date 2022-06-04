class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  
  #いいねの有無を調べるメソッド（自分で決めてよい）
  def favorited_by?(user) #引数にuser
    favorites.exists?(user_id: user.id)
  #existsはFavoritesテーブル内にuser.idが存在（exists?）するかどうか
  end 
end
