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

	validate_uniqness_of :follower_id, scope: :following_id
	validate :follower_id, presence: true
	validate :following_id, presence: true
end
