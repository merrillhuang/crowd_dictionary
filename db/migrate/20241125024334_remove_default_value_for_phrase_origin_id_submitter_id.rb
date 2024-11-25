class RemoveDefaultValueForPhraseOriginIdSubmitterId < ActiveRecord::Migration[7.1]
  def change
    change_column_default :phrases, :submitter_id, nil
    change_column_default :phrases, :origin_id, nil
  end
end
