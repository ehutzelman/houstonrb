class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :identity_url
      t.string :name
      t.string :email
      t.text :bio
      t.string :url
      t.string :twitter
      t.boolean :display
      t.boolean :available

      t.datetime :last_login_at          
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
