class CreateForecasts < ActiveRecord::Migration[6.0]
  def change
    create_table :forecasts do |t|
      t.string     :type,    null: false
      t.date       :date,    null: false
      t.jsonb      :payload, null: false, default: '{}'

      # For tracking errors with 3rd party weather APIs
      t.integer    :status,  null: false, default: 0
      t.timestamp  :last_update
      t.timestamp  :last_update_attempt
      t.jsonb      :error_data

      t.references :resort
      t.timestamps
    end

    add_index :forecasts, [:resort_id, :date, :type], unique: true
  end
end
