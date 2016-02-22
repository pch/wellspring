class CreateWellspringEntries < ActiveRecord::Migration
  def change
    create_table :wellspring_entries do |t|
      t.string :type, index: true
      t.string :title
      t.string :slug, index: true
      t.string :token, index: true
      t.text :body
      t.json :payload
      t.integer :user_id, index: true
      t.string :author_name
      t.datetime :published_at
      t.boolean :draft, default: true, index: true
      t.text :tags, array: true, default: []
      t.integer :parent_id, index: true

      t.timestamps null: false
    end

    add_index :wellspring_entries, :tags, using: 'gin'
  end
end
