class CreateImageUploads < ActiveRecord::Migration
  def change
    create_table :image_uploads do |t|
      t.integer :experience_id
      t.string :image

      t.timestamps null: false
    end
  end
end
