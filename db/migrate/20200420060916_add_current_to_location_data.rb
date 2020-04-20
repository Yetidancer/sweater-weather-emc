class AddCurrentToLocationData < ActiveRecord::Migration[5.2]
  def change
    add_reference :location_data, :current, foreign_key: true
  end
end
