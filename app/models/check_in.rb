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
  mount_uploader :image, ImageUploader

  belongs_to :venue
  belongs_to :user

  after_create :sent_twit!

  def sent_twit!
    if user.provider == 'twitter'
      # twitter_client.update("I'm at #{venue.name}")
      twitter_client.update_with_media("I'm at #{venue.name}",
                                       File.open(image.file.file),
                                       {
                                           lat: venue.latitude,
                                           long: venue.longitude,
                                           display_coordinates: true,
                                           name: venue.name
                                       })
    end
  end

  private
  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_APP_ID']
      config.consumer_secret = ENV['TWITTER_APP_SECRET']
      config.access_token = user.oauth_token
      config.access_token_secret = user.oauth_secret
    end
  end

end
