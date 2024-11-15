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
end
