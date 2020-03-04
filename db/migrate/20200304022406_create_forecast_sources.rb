class CreateForecastSources < ActiveRecord::Migration[6.0]
  def change
    create_table :forecast_sources do |t|
      t.string  :name,       null: false
      t.string  :klass_name, null: false
      t.integer :status,     null: false, default: 0
    end
  end
end
