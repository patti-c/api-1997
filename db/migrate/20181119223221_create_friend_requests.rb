class CreateFriendRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friend_requests do |t|
      t.integer :added_id
      t.integer :adder_id
      t.timestamps
    end
  end
end
