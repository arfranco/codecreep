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
    end

    def analyze
    end

    def find_or_create_by
      @user = @github.get_user(user_name)
      User.find_or_create_by(login: @user["login"]) do |t|
      t.name = @user["name"]
      t.homepage = @user["homepage"]
      t.company = @user["company"]
      t.follower_count = @user["follower_count"] 
      t.following_count = @user["following_count"]
      t.repo_count = @user["repo_count"]
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
