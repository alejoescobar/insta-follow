class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:home]
  require 'open-uri'

  def dashboard
    request = open("https://api.instagram.com/v1/users/self/?access_token=#{current_user.token}")
    data = request.read
    @user_data = JSON.parse(data)['data']
  end

  def home

  end

  def requests
    #code
  end

end
