class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :no_of_days

      t.timestamps
    end
  end
end
