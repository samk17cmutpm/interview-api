class RemoveBoatIdFromGood < ActiveRecord::Migration
  def change
    remove_column :goods, :boat_id, :integer
  end
end
