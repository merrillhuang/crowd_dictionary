# == Schema Information
#
# Table name: ratings
#
#  id           :bigint           not null, primary key
#  rating_val   :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  phrase_id    :integer          not null
#  submitter_id :integer          not null
#
class Rating < ApplicationRecord
  belongs_to :submitter, required: true, class_name: "User", foreign_key: "submitter_id"

  belongs_to :phrase, required: true, class_name: "Phrase", foreign_key: "phrase_id"

  validates :rating_val, presence: true
  validates :phrase_id, presence: true
  validates :submitter_id, presence: true
end
