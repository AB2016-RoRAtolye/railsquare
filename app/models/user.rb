class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
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
end
