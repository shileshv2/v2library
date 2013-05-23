class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :location_id
      t.integer :user_id
      t.string :publisher
      t.string :edition
      t.text :description
      t.string :isbn
      t.decimal :price, :precision => 8, :scale => 2 ,:null => false , :default => 0
      t.integer :status
      t.datetime :purchased_at

      t.timestamps
    end
  end
end
