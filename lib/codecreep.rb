$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'pry'

require 'codecreep/init_db'
require 'codecreep/github'
require "codecreep/version"
require "codecreep/user"


module Codecreep
  class App
    def initialize
      @github = Github.new
    end

    def fetch
      users_input = prompt("Great! Please enter the user names you'd like to fetch by entering the usernames followed by a comma and then a space:", /^\w+$/) 
      users_array = users_input.split(", ")
      users_array.each do |user|
        find_or_create_by(user)
        followers = @github.get_followers(user)
        followers.each do |x|
          find_or_create_by(user)
          end
        following = @github.get_following(user)
        following.each do |x|
          find_or_create_by(user)
        end
      end
    end

    def analyze

    end

    def find_or_create_by(user_name)
      user = @github.get_user(user_name)
      user
      User.find_or_create_by(name: user["login"]) do |t|
      t.name = user["name"]
      t.homepage = user["homepage"]
      t.company = user["company"]
      t.follower_count = user["followers"] 
      t.following_count = user["following"]
      t.repo_count = user["repo_count"]
      end

    end

    def welcome
      prompt("Welcome! Which would you like to do: fetch ('f') users or analyze ('a') users?", /^[fa]$/i) 
    end

    def run
      if welcome == "f"
        self.fetch
      else
        self.analyze
      end
    end
    # prompt the user for input and user can input any number of 
    # usernames and we store it in an array. map the array to get the user names

    def prompt(question, validator)
      puts question
      input = gets.chomp
      until input =~ validator
        puts "Sorry, I didn't understand that."
        puts question
        input = gets.chomp
      end
      input
    end

  end

end

app = Codecreep::App.new
binding.pry
