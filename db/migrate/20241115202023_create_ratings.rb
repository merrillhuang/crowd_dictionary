class CreateRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :ratings do |t|
      t.integer :rating,          null: false
      t.integer :submitter_id,    null: false
      t.integer :phrase_id,       null: false

      t.timestamps
    end
  end
end
