class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.string :name
      t.integer :quantity
      t.integer :boat_id

      t.timestamps null: false
    end
  end
end
