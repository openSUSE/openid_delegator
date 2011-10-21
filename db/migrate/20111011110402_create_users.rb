class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.boolean :admin, :default => false
      t.boolean :enabled, :default => false
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
