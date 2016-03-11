# This migration comes from wellspring (originally 20160208102834)
class CreateWellspringImages < ActiveRecord::Migration
  def change
    create_table :wellspring_images do |t|
      t.string :image
      t.string :token, index: true
      t.integer :width
      t.integer :height
      t.float :ratio
      t.integer :file_size
      t.string  :content_type
      t.boolean :hero, default: false
      t.integer :entry_id, index: true
      t.json :exif

      t.timestamps
    end
  end
end
