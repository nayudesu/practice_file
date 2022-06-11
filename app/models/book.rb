class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
   #ソート機能(カラムの取り出し方を指示する)
   #scope ：任意　=SQL文をメソッド化できる
   #order=取得したレコードを特定のキーで並び替える
  scope :latest, -> {order(created_at: :desc)} #created_at=投稿日のカラム#desc＝大きい方から小さい方に並ぶ(降順)
  scope :old, -> {order(created_at: :asc)} #asc＝小さい方から大きい方に並ぶ(昇順)
  scope :star_count, -> {order(star: :desc)} #
  
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
