class CreateLocationData < ActiveRecord::Migration[5.2]
  def change
    create_table :location_data do |t|
      t.float :latitude
      t.float :longitude
      t.string :city
      t.string :state
      t.string :country
      t.timestamp :created_at
    end
  end
end
