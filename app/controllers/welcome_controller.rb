class WelcomeController < ApplicationController
  def index
  	key = 'y9mJIhH1eO8PZLCAVHS7qlv1EYveJqLi'
  	secret = 'WWPE4atWHynFb8yH'
  	name = 'teststage'			#the name you want to give your bucket
  	policy = 'transient'		#the retention policy you want to register your bucket with
  	file = 'Test.dwg'

  	token = Adn_Viewer.token(key, secret)["access_token"]		#gives you an access token
   	supported_formats = Adn_Viewer.supported_formats(token)		#fills the variable supported_formats with all formats that the viewer supports (in json format) 	
  	Adn_Viewer.create_bucket(token, name, policy)				#creates the bucket
  	name =  Adn_Viewer.check_bucket(token, name)["key"]			#checks status and returns bucket name

  	#puts Adn_Viewer.upload_file(token, name, file)				#upload the file you want to view
  	#puts JSON.parse(CurbFu.get({:host => 'developer.api.autodesk.com', :path => '/oss/v1/buckets/' + name + '/objects/' + file, :protocol => "https", :headers => { "Authorization" => "Bearer " + token, "Content-Type" => "application/octet-stream" , "Content-Length" => 308331 }, "upload-file" => file }).body)
	#bound = "AaB03xZZZZZZ11322321111XSDW"
	#uri = URI("https://developer.api.autodesk.com/oss/v1/buckets/" + name + "/objects/" + file)
	#http = Net::HTTP.new(uri.host, uri.port)
	#http.use_ssl = true
	#request = Net::HTTP::Put.new(uri)
	#request.body_stream=File.open(file)
	#request["content-type"] = 'application/octet-stream'
	#request["Content-Length"] = 308331
	#request["authorization"] = 'Bearer ' + token
	#request.add_field('session', bound)
	#puts http.request(request).read_body
	
	urn = 'urn:adsk.objects:os.object:teststage/Test.dwg'
	urn = Base64.urlsafe_encode64(urn)				#encodes the urn to allow translation	
	Adn_Viewer.register(token, urn)			#registers for translation
	gon.token = token
	gon.urn = urn
  end
end
