class AddImagesToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :images, :string, array: true, default: []
  end
end
