class WelcomeController < ApplicationController
  def index
  	key = 'y9mJIhH1eO8PZLCAVHS7qlv1EYveJqLi'
  	secret = 'WWPE4atWHynFb8yH'
  	name = 'sfndsskdssn'		#the name you want to give your bucket
  	policy = 'transient'		#the retention policy you want to register your bucket with

  	supported_formats = Adn_Viewer.supported_formats(token)		#fills the variable supported_formats with all formats that the viewer supports (in json format)
  	token = Adn_Viewer.token(key, secret)["access_token"]		#gives you an access token
  	Adn_Viewer.create_bucket(token, name, policy)				#creates the bucket
  	name = Adn_Viewer.check_bucket(token, name)["key"]			#checks status and returns bucket name	

  end
end
