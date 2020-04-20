class CreateDaily < ActiveRecord::Migration[5.2]
  def change
    create_table :dailies do |t|
      t.string :day
      t.string :icon
      t.string :description
      t.float :precipitation
      t.integer :high
      t.integer :low
      t.references :location_data, foreign_key: true
    end
  end
end
