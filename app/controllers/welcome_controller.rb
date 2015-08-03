class WelcomeController < ApplicationController
  def index
  	key = 'y9mJIhH1eO8PZLCAVHS7qlv1EYveJqLi'				  #credentials from developer.autodesk.com
  	secret = 'WWPE4atWHynFb8yH'
  	name = 'teststage'										  #the name you want to give your bucket
  	policy = 'transient'									  #the retention policy you want to register your bucket with
  	filepath ||= "#{Rails.root}/public/Test.dwg"
  	filename = "Test.dwg"

  	token = Adn_Viewer.token(key, secret)["access_token"]	  #gives you an access token

   	supported_formats = Adn_Viewer.supported_formats(token)	  #fills the variable supported_formats with all formats that the viewer supports (in json format)

  	Adn_Viewer.create_bucket(token, name, policy)			  #creates the bucket
  	name = Adn_Viewer.check_bucket(token, name)["key"]		  #checks status and returns bucket name

  	urn = Adn_Viewer.upload_file(token, name, filename, filepath)["objects"][0].first.to_s		#upload the file you want to view
  	urn = urn[8...-2]										  #formats the urn correctly
	urn = Base64.urlsafe_encode64(urn)						  #encodes the urn to allow translation	

	Adn_Viewer.register(token, urn)							  #registers for translation

	gon.token = token 										  #sets variables up to use in javascript for the viewer
	gon.urn = urn
  end
end
