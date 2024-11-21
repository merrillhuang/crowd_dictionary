# == Schema Information
#
# Table name: phrases
#
#  id           :bigint           not null, primary key
#  content      :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  language_id  :integer          not null
#  origin_id    :integer
#  submitter_id :integer          default(0), not null
#
class Phrase < ApplicationRecord
  belongs_to :submitter, required: true, class_name: "User", foreign_key: "submitter_id"

  has_many  :ratings, class_name: "Rating", foreign_key: "phrase_id", dependent: :destroy

  has_many  :translations, class_name: "Phrase", foreign_key: "origin_id", dependent: :destroy

  belongs_to :origin_word, required: true, class_name: "Phrase", foreign_key: "origin_id", counter_cache: :translations_count

  belongs_to :target_language, required: true, class_name: "Language", foreign_key: "language_id"
end
