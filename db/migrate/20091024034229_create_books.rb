class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :asin
      t.string :title
      t.string :authors
      t.string :url
      t.string :image_url
      t.datetime :published_at
      t.boolean :available
      
      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
