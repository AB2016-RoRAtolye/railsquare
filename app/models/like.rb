# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  venue_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Like < ActiveRecord::Base
	belongs_to :user
	belongs_to :venue

	validates :user_id, uniqueness: { scope: :venue_id }
end
