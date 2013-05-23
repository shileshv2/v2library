class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :book_id
      t.integer :employee
      t.string  :employee_name
      t.string :employee_email
      t.integer :user_id
      t.integer :transaction_type
      t.datetime :transaction_date

      t.timestamps
    end
  end
end
