class Relationship < ApplicationRecord
  belongs_to :following, class_name: "User" #フォローする側/followingはテーブル名でuserテーブルを参照するように記述
  #(実際にuserテーブルとして存在はしていないが、関係を区別するために名前をつける/中間テーブル経由)
  belongs_to :follower, class_name: "User" #フォローされる側/followはテーブル名でuserテーブルを参照するように記述
  
end
