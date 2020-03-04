class CreateDays < ActiveRecord::Migration[6.0]
  def change
    create_table :days do |t|
      t.string :type,         null: false
      t.date   :date,         null: false
      t.jsonb  :weather_data, null: false, default: '{}'

      t.references :resort,          index: true
      t.references :forecast_source, index: true

      # Don't trust ActiveRecord's updated_at. We control this one so we know
      # it'll be true every time we check it.
      t.timestamp  :last_update
      t.timestamps
    end

    add_index :days, [:resort_id, :date, :forecast_source_id]
  end
end
