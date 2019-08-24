class CreateCheckIns < ActiveRecord::Migration[5.1]
  def change
    create_table :check_ins do |t|
      t.integer :owner_id
      t.integer :location_id
      t.string :image
      t.text :caption

      t.timestamps
    end
  end
end
