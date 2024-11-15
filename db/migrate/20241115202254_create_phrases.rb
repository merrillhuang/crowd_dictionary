class CreatePhrases < ActiveRecord::Migration[7.1]
  def change
    create_table :phrases do |t|
      t.string :content,          null: false
      t.integer :submitter_id,    null: false, default: 0
      t.integer :language_id,     null: false
      t.integer :origin_id        

      t.timestamps
    end
  end
end
