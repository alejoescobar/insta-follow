class User < ApplicationRecord
  require 'open-uri'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable,
         :omniauth_providers => [:instagram]

  after_create :initial_counts

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

  def initial_counts
    request = open("https://api.instagram.com/v1/users/self/?access_token=#{self.token}")
    data = request.read
    user_data = JSON.parse(data)['data']
    self.update(follows: user_data['counts']['follows'], followed_by: user_data['counts']['followed_by'])
  end

end
