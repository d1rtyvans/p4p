class CreateOutages < ActiveRecord::Migration[6.0]
  def change
    create_table :outages do |t|
      t.references :forecast_source, index: true
      t.jsonb      :error_data,      null: false
      t.timestamp  :resolved_at
      t.timestamps
    end
  end
end
