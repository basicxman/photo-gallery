class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :image_file_name
      t.string :image_content_type
      t.string :image_file_size
      t.integer :gallery_id
      t.integer :user_id
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
