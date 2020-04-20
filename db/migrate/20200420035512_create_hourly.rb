class CreateHourly < ActiveRecord::Migration[5.2]
  def change
    create_table :hourlies do |t|
      t.string :time
      t.integer :temp
      t.string :icon
      t.references :location_data, foreign_key: true
    end
  end
end
