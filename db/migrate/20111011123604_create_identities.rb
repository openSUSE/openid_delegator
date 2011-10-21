class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :name, :null => false, :unique => true
      t.integer :user_id
      t.string :openid_server, :null => false
      t.string :openid_delegate, :null => false
      t.string :openid_url, :null => false

      t.timestamps
    end

    add_index :identities, :name
  end
end
