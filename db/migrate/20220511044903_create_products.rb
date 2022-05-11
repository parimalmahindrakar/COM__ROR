class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :CompanyName
      t.string :Model
      t.integer :stock
      t.float :price
      t.string :device

      t.timestamps null: false
    end
  end
end
