# == Schema Information
#
# Table name: check_ins
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  venue_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image      :string
#

class CheckIn < ActiveRecord::Base
	belongs_to :venue
	belongs_to :user

	validates :user_id, uniqueness: { scope: :venue_id }

	mount_uploader :image, ImageUploader

	#after_create :sent_twit!

	def sent_twit!
		if user.provider == "twitter"
			begin
				twitter_client.update_with_media(
						"I'm at #{venue.name}",
						File.open(image.file.file),
						{
								lat: venue.latitude,
								long: venue.longitude,
								display_coordinates: true
						}
				)
			rescue
				puts "Twitter Client error"
			end
		end
	end

	def venue_name
		venue.name
	end

	def venue_address
		venue.address
	end

	private

	def twitter_client
		Twitter::REST::Client.new do |config|
			config.consumer_key        = ENV["TWITTER_APP_ID"]
			config.consumer_secret     = ENV["TWITTER_APP_SECRET"]
			config.access_token        = user.oauth_token
			config.access_token_secret = user.oauth_secret
		end
	end
end
