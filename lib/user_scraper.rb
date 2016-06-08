class UserScraper
  require 'capybara'
  require 'capybara/webkit'
  require 'capybara/dsl'
  require 'open-uri'
  require 'byebug'
  include Capybara::DSL

  Capybara.default_driver = :webkit
  Capybara.javascript_driver = :webkit
  Capybara.default_max_wait_time = 15
  Capybara::Webkit.configure do |config|
    config.allow_unknown_urls
  end

  def self.instagram_names
    instagram_authenticate

    Capybara.visit 'https://www.instagram.com/nike/'

    Capybara.find('._m2soy').click

    Timeout.timeout(Capybara.default_max_wait_time) do
    	loop until Capybara.page.evaluate_script('jQuery.active').zero?
    end

    username_array = []

    counter = 1
    old_counter = 0

    while true
      Capybara.page.execute_script "window.scrollBy(0,10000)"
    	loop until Capybara.page.evaluate_script('jQuery.active').zero?
      counter = Capybara.all("._j7lfh").count
      if counter == old_counter || counter > 1
        puts "finished!!!"
        Capybara.all("._j7lfh").each do |user|
          username_array << user.text
        end
        break
      else
        old_counter = all("._j7lfh").count
      end
      puts Capybara.all("._j7lfh").count
    end

    Timeout.timeout(Capybara.default_wait_time) do
    	loop until Capybara.page.evaluate_script('jQuery.active').zero?
    end
    username_array
  end

  def self.instagram_authenticate
    Capybara.visit 'https://www.instagram.com/accounts/login/'
    Capybara.within("._rwf8p") do
      Capybara.fill_in 'Username', :with => 'instatest1508'
      Capybara.fill_in 'Password', :with => 'I12345678'
    end
    Capybara.click_button("Log in")
    Timeout.timeout(Capybara.default_max_wait_time) do
    	loop until Capybara.page.evaluate_script('jQuery.active').zero?
    end
  end

end
