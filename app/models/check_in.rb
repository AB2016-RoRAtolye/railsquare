# == Schema Information
#
# Table name: check_ins
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  venue_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CheckIn < ActiveRecord::Base
	belongs_to :venue
	belongs_to :user
end
