class WelcomeController < ApplicationController
  def index
  	key = 'y9mJIhH1eO8PZLCAVHS7qlv1EYveJqLi'
  	secret = 'WWPE4atWHynFb8yH'
  	name = 'sfndsskdssn'   #the name you want to give your bucket
  	policy = 'transient'

  	token = Adn_Viewer.token(key, secret)["access_token"]
  	key =  Adn_Viewer.create_bucket(token, name, policy)["key"]
  	
  end
end
