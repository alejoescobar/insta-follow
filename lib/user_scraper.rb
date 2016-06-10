class UserScraper
  require 'capybara'
  require 'capybara/webkit'
  require 'capybara/dsl'
  require 'open-uri'
  require 'byebug'
  include Capybara::DSL

  def self.capybara_config
    Capybara.default_driver = :webkit
    Capybara.javascript_driver = :webkit
    Capybara.default_max_wait_time = 15
  end

  def self.instagram_names(user)
    instagram_authenticate

    Capybara.visit "https://www.instagram.com/#{user}/"

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
        Capybara.all("._6jvgy").each do |user|
          user_hash = {}
          Capybara.within(user) do
            user_hash[:name] = Capybara.find("._2uju6").text
            user_hash[:username] = Capybara.find("._j7lfh").text
            user_hash[:page] = "https://www.instagram.com" +  Capybara.find("._j7lfh")["href"]
            user_hash[:image] = Capybara.find("._a012k")["src"]
          end
          username_array << user_hash
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
    capybara_config
    begin
      Capybara.visit 'https://www.instagram.com/accounts/login/'
      Capybara.within("._rwf8p") do
        Capybara.fill_in 'Username', :with => 'instatest1508'
        Capybara.fill_in 'Password', :with => 'I12345678'
      end
      Capybara.click_button("Log in")
      Timeout.timeout(Capybara.default_max_wait_time) do
      	loop until Capybara.page.evaluate_script('jQuery.active').zero?
      end
    rescue
      puts "Already logged in!"
    end
  end

end
