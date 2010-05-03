class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.string :description
      t.integer :requester_user_id
      t.integer :presenter_user_id
      t.boolean :is_active, :default => true
      t.integer :topic_votes_count, :default => 0
      
      t.timestamps
    end
  end

  def self.down
    drop_table :topics
  end
end
