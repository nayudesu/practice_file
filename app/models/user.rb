class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
      
  has_many :books, dependent: :destroy
  
  validates :name, uniqueness: true, length: { in: 2..20 } #２〜２０文字
  validates :introduction, length: {maximum: 50}#最大５０字まで,{}追加？

  
  has_one_attached :profile_image #プロフィール画像を扱えるようにする
  
  def get_profile_image(width, height) 
    unless profile_image.attached? #unless=profile_imageがなかったとき
      file_path = Rails.root.join('app/assets/images/no_image_jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
end
