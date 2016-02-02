# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#  name                   :string
#  image_url              :string
#  oauth_token            :string
#  oauth_secret           :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :twitter, :google_oauth2]

  has_many :check_ins
  has_many :likes

  has_many :follower_users, class_name: "Follow", foreign_key: "following_id", dependent: :destroy
  has_many :followers, through: :follower_users#, source: :follower


  has_many :following_users, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :following_users, source: :followed

  after_create :send_welcome_mail


  def self.from_facebook_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      if auth.info.email.present?
        user.email = auth.info.email
      else
        user.email = "#{SecureRandom.hex(16)}@gmail.com"
      end
      user.password = Devise.friendly_token[0,20]
      user.image_url = auth.info.image
      user.name = auth.info.name
    end
  end

  def self.from_twitter_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = "#{SecureRandom.hex(16)}@gmail.com"
      user.password = Devise.friendly_token[0,20]
      user.image_url = auth.info.image
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_secret = auth.credentials.secret
    end
  end

  def self.from_google_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create(name: data["name"], email: data["email"],password: Devise.friendly_token[0,20])
    end
    user
  end

  def checked_venue?(venue)
    check_ins.where(venue_id: venue.id).present?
  end

  def liked_venue?(venue)
    likes.where(venue_id: venue.id).present?
  end

  def follow(follower)
    followers << follower
    WebsocketRails[:follow].trigger(:success, self)
  end

  def unfollow(follower)
    followers.destroy(follower)
  end

  def send_welcome_mail
    UserMailer.welcome(self).deliver_now
  end
end
