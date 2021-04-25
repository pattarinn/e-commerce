class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :product_name
      t.string :customer_name
      t.string :address
      t.integer :amount

      t.timestamps
    end
  end
end
