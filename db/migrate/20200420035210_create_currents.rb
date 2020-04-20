class CreateCurrents < ActiveRecord::Migration[5.2]
  def change
    create_table :currents do |t|
      t.integer :temp
      t.integer :high
      t.integer :low
      t.string :description
      t.string :icon
      t.integer :feels_like
      t.integer :humidity
      t.integer :visibility
      t.integer :uv_index
      t.string :sunrise
      t.string :sunset
      t.references :location_data, foreign_key: true
    end
  end
end
