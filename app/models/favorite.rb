class Favorite < ApplicationRecord
  belongs_to :user 
  belongs_to :book #一つの投稿に１いいね
  
  validates_uniqueness_of :book_id, scope: :user_id
  #1人のユーザーは１いいねのみというバリデーション
  #validates_uniqueness_of でbook_idの値が一意であることを示す
  #scopeで:user_id範囲を指定して、一意かどうかを判断
end
