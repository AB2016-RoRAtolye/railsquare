# == Schema Information
#
# Table name: follows
#
#  id           :integer          not null, primary key
#  follower_id  :integer
#  following_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Follow < ActiveRecord::Base
	belongs_to :follower, foreign_key: :follower_id, class_name: 'User'
	belongs_to :following, foreign_key: :following_id, class_name: 'User'

	validates :following_id, uniqueness: { scope: :follower_id }
	validates :follower_id, presence: true
	validates :following_id, presence: true

	def follower_name
		follower.name
	end

	def following_name
		following.name
	end
end
