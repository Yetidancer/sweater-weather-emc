class CreateForecast < ActiveRecord::Migration[5.2]
  def change
    create_table :forecasts do |t|
      t.string :summary
      t.string :current_temperature
      t.references :antipode, foreign_key: true
    end
  end
end
