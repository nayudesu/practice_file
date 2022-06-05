class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  #フォロー機能
  # foreign_key（FK）には、@user.中間テーブルとした際に「@user.idがfollowing_idなのかfollower_idなのか」を指定します。
  has_many :relationships, class_name: 'Relationship', foreign_key: :following_id, dependent: :destroy
  #フォローする側からのhas_manyか不明のためforeign_keyで指定(フォローする側)
  has_many :followings, through: :relationships, source: :follower
  #あるユーザーがフォローしている人全員持ってくる=あるユーザからフォローされている人をとってくる/followings(任意)

  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :follower_id, dependent: :destroy
  ##11と重複するため仮名で指定して、モデルを指定する
  #フォローされる側からのhas_manyか不明のためforeign_keyで指定
  has_many :followers, through: :reverse_of_relationships, source: :following
  #あるユーザーがフォローされている人全員持ってくる=自分をフォローしていくれている人/followers(任意)

  
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  
  #画像
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  #フォロー機能(コントローラやビューで使用するため)
  # ユーザーをフォローする
  def follow(user)
    reverse_of_relationships.create(following_id: user.id) #
  end 
  
  # ユーザーのフォローを外す
  def unfollow(user)
    reverse_of_relationships.find_by(following_id: user.id).destroy
  end 
  
  # フォローしていればtrueを返す
  def following?(user)
    followers.include?(user)
  end
  
end
