class PagesController < ApplicationController
  before_action :authenticate_user!
  require 'open-uri'

  def home
    request = open("https://api.instagram.com/v1/users/self/?access_token=#{current_user.token}")
    data = request.read
    @user_data = JSON.parse(data)['data']
  end

  def requests
    #code
  end

end
