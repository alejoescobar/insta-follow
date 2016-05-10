class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable,
         :omniauth_providers => [:instagram]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.nickname  # assuming the user model has a nickname
      user.token = auth.credentials.token
      # user.media = auth.info.counts.media
      # user.follows = auth.info.counts.follows
      # user.followed_by = auth.info.counts.followed_by
    end
  end
end
