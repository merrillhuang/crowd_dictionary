# == Schema Information
#
# Table name: ratings
#
#  id           :bigint           not null, primary key
#  rating       :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  phrase_id    :integer          not null
#  submitter_id :integer          not null
#
class Rating < ApplicationRecord
end
