class AddBoatRefToGood < ActiveRecord::Migration
  def change
    add_reference :goods, :boat, index: true, foreign_key: true
  end
end
