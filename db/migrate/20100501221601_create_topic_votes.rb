class CreateTopicVotes < ActiveRecord::Migration
  def self.up
    create_table :topic_votes do |t|
      t.integer :user_id
      t.integer :topic_id

      t.timestamps
    end
  end

  def self.down
    drop_table :topic_votes
  end
end
