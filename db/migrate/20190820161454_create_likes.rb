class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.integer :author_id
      t.integer :photo_id
      t.integer :location_id

      t.timestamps
    end
  end
end
