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

      t.references :resort, index: true
      t.timestamps
    end

    add_index :forecasts, [:date, :resort_id, :type], unique: true
  end
end
