require 'httparty'

module Codecreep
  class Github
    include HTTParty
    base_uri 'https://api.github.com'
    basic_auth ENV['GH_USER'], ENV['GH_PASS']

    def get_user(user_id)
      self.class.get("/users/#{username}")
    end

    # different api calls similar to issues
    # all get requests


    # get all of the 10 users and put them into the database
    # call to get user from Github
    #GET /users/:username to put each of the ten users in the databse
    #get all of the followers and all the people they are following
    
  end
end
