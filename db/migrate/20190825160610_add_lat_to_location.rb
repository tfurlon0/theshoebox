class AddLatToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :lat, :float
  end
end
