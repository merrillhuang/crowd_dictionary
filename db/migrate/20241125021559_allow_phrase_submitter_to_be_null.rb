class AllowPhraseSubmitterToBeNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :phrases, :submitter_id, true
  end
end
