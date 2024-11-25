class ChangePhraseOriginIdDefaultZero < ActiveRecord::Migration[7.1]
  def change
    change_column_default :phrases, :origin_id, 0
  end
end
