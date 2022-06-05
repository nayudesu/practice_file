class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :following_id, null:false #フォローする側
      t.integer :follower_id, null:false #フォローされる側

      t.timestamps
    end
  end
end
