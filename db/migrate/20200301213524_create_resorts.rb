class CreateResorts < ActiveRecord::Migration[6.0]
  def change
    create_table :resorts do |t|
      t.string :name, null: false
      t.string :uid,  null: false
      t.decimal :lat, precision: 10, scale: 6, null: false
      t.decimal :lon, precision: 10, scale: 6, null: false
    end

    add_index :resorts, :uid, unique: true
  end
end
