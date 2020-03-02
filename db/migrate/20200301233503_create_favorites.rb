class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.references :user,   index: true
      t.references :resort, index: true

      t.timestamps
    end
  end
end
