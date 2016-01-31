class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :twitter, :google_oauth2]

  has_many :check_ins

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
    end
  end

  def self.from_google_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    # Uncomment the section below if you want users to be created if they don't exist
    # unless user
    #     user = User.create(name: data["name"],
    #        email: data["email"],
    #        password: Devise.friendly_token[0,20]
    #     )
    # end
    user
end
end
