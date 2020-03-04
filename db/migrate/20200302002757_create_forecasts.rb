class CreateForecasts < ActiveRecord::Migration[6.0]
  def change
    create_table :forecasts do |t|
      t.string     :type,         null: false
      t.date       :date,         null: false
      t.jsonb      :weather_data, null: false

      t.belongs_to :resort, index: true, foreign_key: true
      t.timestamps
    end

    add_index :forecasts, [:resort_id, :date, :type], unique: true
  end
end
