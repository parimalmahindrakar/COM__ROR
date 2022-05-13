class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :companyname
      t.string :model
      t.integer :stock
      t.float :price
      t.string :device

      t.timestamps null: false
    end
  end
end
