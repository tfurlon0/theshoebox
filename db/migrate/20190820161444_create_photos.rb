class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.integer :author_id
      t.integer :comments_count
      t.integer :likes_count
      t.integer :location_id
      t.text :caption
      t.string :image

      t.timestamps
    end
  end
end
