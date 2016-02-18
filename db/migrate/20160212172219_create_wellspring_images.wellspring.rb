# This migration comes from wellspring (originally 20160208102834)
class CreateWellspringImages < ActiveRecord::Migration
  def change
    create_table :wellspring_images do |t|
      t.string :image
      t.integer :width
      t.integer :height
      t.integer :file_size
      t.string  :content_type

      t.timestamps
    end
  end
end
