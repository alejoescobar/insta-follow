# require 'rubygems'
# require 'capybara'
# require 'nokogiri'
# require 'capybara/poltergeist'
#
# # url = 'https://www.instagram.com/kimkardashian'
# # doc = Nokogiri::HTML(open(url))
# # puts doc.at_css('title').text
# # p doc.css('li')
#
# # Capybara.current_driver = :selenium # Desactivate Selenium
# Capybara.app_host = 'https://www.instagram.com'
# browser = Capybara.current_session
#
# # Open the site
# browser.visit("/victoriassecret/")
# # Define Capybara object as our page
# page = Capybara.current_session

require 'capybara'
# require 'capybara/poltergeist'
require 'capybara/webkit'
require 'capybara/dsl'
require 'nokogiri'
require 'open-uri'
require 'byebug'

include Capybara::DSL

# Capybara.default_driver = :poltergeist
Capybara.default_driver = :webkit
Capybara.javascript_driver = :webkit
# Capybara.javascript_driver = :poltergeist
Capybara.default_max_wait_time = 15
Capybara::Webkit.configure do |config|
  config.allow_unknown_urls
end

# visit "http://ngauthier.com/"

# all(".posts .post").each do |post|
#   title = post.find("h3 a").text
#   url   = post.find("h3 a")["href"]
#   date  = post.find("h3 small").text
#   summary = post.all(".post p")[1].text
#
#   puts title
#   puts url
#   puts date
#   puts summary
#   puts ""
# end

visit 'https://www.instagram.com/accounts/login/'
within("._rwf8p") do
  fill_in 'Username', :with => 'instatest1508'
  fill_in 'Password', :with => 'I12345678'
end
click_button("Log in")
Timeout.timeout(Capybara.default_max_wait_time) do
	loop until page.evaluate_script('jQuery.active').zero?
end

visit 'https://www.instagram.com/nike/'

find('._m2soy').click

Timeout.timeout(Capybara.default_max_wait_time) do
	loop until page.evaluate_script('jQuery.active').zero?
end

# page = Capybara.current_session
# all("._j7lfh").each do |user|
#   puts user.text
# end

puts "--------"

counter = 1
old_counter = 0

while true
  page.execute_script "window.scrollBy(0,10000)"
  # Timeout.timeout(Capybara.default_max_wait_time) do
  # 	loop until page.evaluate_script('jQuery.active').zero?
  # end
	loop until page.evaluate_script('jQuery.active').zero?
  counter = all("._j7lfh").count
  if counter == old_counter || counter > 1
    puts "finished!!!"
    # all("._o0442").each do |follow|
    #   puts follow
    #   byebug
    #   follow.click
    # end
    all("._6jvgy").each do |user|
      within(user) do
        find("._o0442").click
        find("._j7lfh").text
        puts user.text
      end
      Timeout.timeout(Capybara.default_max_wait_time) do
      	loop until page.evaluate_script('jQuery.active').zero?
      end
    end
    break
  else
    old_counter = all("._j7lfh").count
  end
  puts all("._j7lfh").count
end

Timeout.timeout(Capybara.default_wait_time) do
	loop until page.evaluate_script('jQuery.active').zero?
end

# all("._j7lfh").each do |user|
#   puts user.text
# end

save_and_open_page
# followers = find('._m2soy')
# byebug
# page.find_link('._m2soy')
# page.click_link_or_button(followers)
# # expect(page).to have_content('_q44m8 _guthk _7z4zb')
# Timeout.timeout(Capybara.default_wait_time) do
# 	loop until page.evaluate_script('jQuery.active').zero?
# end
#


# Timeout.timeout(Capybara.default_wait_time) do
#   save_and_open_page
# end
