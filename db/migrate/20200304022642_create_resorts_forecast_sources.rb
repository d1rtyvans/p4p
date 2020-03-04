class CreateResortsForecastSources < ActiveRecord::Migration[6.0]
  def change
    create_table :resorts_forecast_sources do |t|
      t.references :resort,          index: true
      t.references :forecast_source, index: true

      t.timestamps
    end
  end
end
