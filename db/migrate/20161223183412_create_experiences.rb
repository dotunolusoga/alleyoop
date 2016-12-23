class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :experience_type
      t.string :experience_title
      t.text :tagline
      t.text :summary
      t.text :about_host
      t.datetime :experience_date
      t.datetime :start_time
      t.datetime :end_time
      t.string :location_name
      t.text :street
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :drinks
      t.boolean :alcohol
      t.string :food
      t.boolean :internet
      t.boolean :parking
      t.string :tickets
      t.text :note
      t.text :guest_requirement
      t.integer :capacity
      t.integer :price
      t.boolean :active

      t.timestamps null: false
    end
  end
end
