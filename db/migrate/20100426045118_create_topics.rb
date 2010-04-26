class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.string :description
      t.integer :requester_user_id
      t.integer :presenter_user_id
      t.bool :is_active
      
      t.timestamps
    end
  end

  def self.down
    drop_table :topics
  end
end
