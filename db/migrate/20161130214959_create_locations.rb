class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :title
      t.text :description
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :postcode
      t.string :musical_instrument
      t.decimal :night_rate, precision: 5
      t.integer :guests
      t.references :member, foreign_key: true

      t.timestamps
    end
  end
end
