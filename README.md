# adn_viewer_gem_test_app

[![adn](https://img.shields.io/badge/adn_viewer_gem-v1.0.0-yellow.svg)](https://www.ruby-lang.org/en/)
[![Ruby](https://img.shields.io/badge/Ruby-v2.2.2-red.svg)](https://www.ruby-lang.org/en/)
[![Rails](https://img.shields.io/badge/Rails-v4.2.3-brightgreen.svg)](http://rubyonrails.org/)
[![LMV](https://img.shields.io/badge/View%20%26%20Data%20API-v1.2.15-green.svg)](http://developer-autodesk.github.io/)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://opensource.org/licenses/MIT)


<b>Note:</b> For using this sample, you need a valid oAuth credential for the translation / extraction portion.
Visit this [page](https://developer.autodesk.com) for instructions to get on-board.


## Links
[Ruby Gem adn_viewer](https://rubygems.org/gems/adn_viewer) <br />
[ADN website](https://developer.autodesk.com/) <br />
[How the API Works and sample code](https://developer.autodesk.com/api/view-and-data-api/) <br />
[Live Sample](http://developer-autodesk.github.io/LmvQuickStart/) <br />

## Motivation

Our View and Data API Beta adds powerful 2D and 3D viewing functionality to your web apps.
Our REST and JavaScript API makes it easier to create applications that can view, zoom and interact with 2D and
3D models from over 60+ model formats with just a web browser, no plugin required!

This app serves as a sample for developers seeking to getting a viewer up and running in their app and supporting authentication, bucket creation, uploading of files and registering those files for translation in the same.

The README serves as a tutorial for adn_viewer gem users.


## Description

This tutorial is intended for developers with not a lot of experience with Rails or the Autodesk Viewer.

The gem source code can be found here: [adn_viewer](https://github.com/Developer-Autodesk/adn_viewer)

It closely follows the steps described in the documentation:

* http://developer.api.autodesk.com/documentation/v1/vs_quick_start.html

In order to make use of this sample, you need to register your consumer key:

* https://developer.autodesk.com > My Apps

This provides the credentials to supply to the http requests on the Autodesk server.

## Tutorial

Follow the instructions here to install Ruby and Ruby on Rails: [rubyonrails.org/download](http://rubyonrails.org/download/). <br />
Note: some sort of package management is recommended with Ruby and RoR. For example, [RVM](https://rvm.io/) is perfect for the job.
Once you've downloaded Ruby, install Rails (this can take a very long while), then create an app and go into the app directory:
```
gem install rails
rails new yourappname
cd yourappname
```

Add this to your Gemfile inside the app you just created to install the adn_viewer gem:
```
gem 'adn_viewer'
```

Now, add the following to your Gemfile to install dependencies:
```
gem 'curb-fu'
gem 'curb'
gem 'gon'
gem 'json'
```

Finally install the all the requisite gems and get the server running:
```
bundle install
rails server
```

You should have a rails server up and running on http://localhost:3000 now. Follow these steps to setup uploading and the viewer:

Generate a controller, a function within and its corresponding view:
```
rails generate controller welcome index
```

Now, open the file config/routes.rb in your editor and uncomment the following line:
```
root 'welcome#index'
```

Add the following code to your welcome controller (app/controllers/welcome_controller.rb), thereby changing the index function to:
```
def index
    key = 'yourkey'                                           #credentials from developer.autodesk.com
    secret = 'yoursecret'
    name = 'bucketname'                                       #the name you want to give your bucket
    policy = 'transient'                                      #the retention policy you want to register your bucket with
    filepath ||= "yourfilepath"                               #such as "#{Rails.root}/public/Test.dwg"
    filename = "yourfilename"                                 #such as "Test.dwg"

    token = Adn_Viewer.token(key, secret)["access_token"]     #gives you an access token

    supported_formats = Adn_Viewer.supported_formats(token)   #fills the variable supported_formats with all formats that the viewer supports (in json format)

    Adn_Viewer.create_bucket(token, name, policy)             #creates the bucket
    name = Adn_Viewer.check_bucket(token, name)["key"]        #checks status and returns bucket name

    urn = Adn_Viewer.upload_file(token, name, filename, filepath)["objects"][0].first.to_s      #upload the file you want to view
    urn = urn[8...-2]                                         #formats the urn correctly
    urn = Base64.urlsafe_encode64(urn)                        #encodes the urn to allow translation 

    Adn_Viewer.register(token, urn)                           #registers for translation

    gon.token = token                                         #sets variables up to use in javascript for the viewer
    gon.urn = urn
  end
```

Go ahead and change the feilds here with your credentials, choice of bucket name and file. Read through the commands and comments to understand the gem functions. <br />
Finally, add the following code to file app/views/welcome/index.html.erb:
```
<!DOCTYPE html>
<html>
<head>
<%= include_gon %>
<link rel="stylesheet" href="https://developer.api.autodesk.com/viewingservice/v1/viewers/style.css?v=v1.2.17" type="text/css">
<script src="https://developer.api.autodesk.com/viewingservice/v1/viewers/viewer3D.min.js?v=v1.2.17"></script>
<script>
    // change the token and urn(translated file location) before you try to run
    // easiest is to go through steps on http://shiya.github.io/Intro-View-and-Data/
    var token = gon.token;
    var urn = gon.urn;
    function getToken() {
        return token;
    }
    function loadDocument(viewer, documentId) {
        // Find the first 3d geometry and load that.
        Autodesk.Viewing.Document.load(documentId, function(doc) {
        var geometryItems = [];
        geometryItems = Autodesk.Viewing.Document.getSubItemsWithProperties(doc.getRootItem(), {
            'type' : 'geometry',
            'role' : '3d'
        }, true);
        if (geometryItems.length > 0) {
            viewer.load(doc.getViewablePath(geometryItems[0]));
        }
     }, function(errorMsg) {// onErrorCallback
        alert("Load Error: " + errorMsg);
        });
    }
    
    function initialize() {
        var options = {
            'document' : 'urn:' + urn,
            'env':'AutodeskProduction',
            'getAccessToken': getToken,
            'refreshToken': getToken,
            };
        var viewerElement = document.getElementById('viewer');
        var viewer = new Autodesk.Viewing.Viewer3D(viewerElement, {});
        Autodesk.Viewing.Initializer(options,function() {
            viewer.initialize();
            loadDocument(viewer, options.document);
        });
    }
</script>
</head>

<body onload="initialize()">
    <div id="viewer" style="position:absolute; width:98.7%; height:97.5%;"></div>
</body>

</html>
```

Now restart your server and go to http://localhost:3000 to get an access token, create a bucket, upload a file, register it for translation and view it on the Autodesk Viewer. Enjoy the power of 3D!

Note: Refresh after a while if you see a load error alert in the viewer. Your file is still translating.

You may view the final code that gets the server up and running in this repo. Cloning this repo, changing variable names and starting up the rails server after installing the bundle may serve you well too!

Finally, here is a more complex app built incorporating the API: [sample-ruby-on-rails-app-prototyping](https://github.com/Developer-Autodesk/sample-ruby-on-rails-app-prototyping)



--------

## License

This sample is licensed under the terms of the [MIT License](http://opensource.org/licenses/MIT). Please see the [LICENSE](LICENSE) file for full details.


## Written by

Pratham Makhni Alag (Autodesk Developer Network)<br />
http://www.autodesk.com/adn<br />


For troubleshooting, visit forums.autodesk.com and post with reference to the view and data api.
