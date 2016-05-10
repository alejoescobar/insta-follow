class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers => [:instagram]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.data.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.data.username   # assuming the user model has a name
      user.image = auth.data.profile_picture # assuming the user model has an image
    end
  end
end
