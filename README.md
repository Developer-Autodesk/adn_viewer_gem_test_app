# adn_viewer_gem_test_app

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

Follow the instructions here to install Ruby and Ruby on Rails: [rubyonrails.org/download](http://rubyonrails.org/download/)
Once you've downloaded Ruby, install Rails (this can take a very long while):
```
gem install rails
```

Now, add this to your gemfile to install the adn_viewer gem:
```
gem 'adn_viewer'
```

Now, add the following to your gemfile to install dependencies:
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

You should have a rails server up and running on http://localhost:3000 now. Shut it down for now and follow these steps (or you may keep it running but restart it when you're done with these instructions):

Now generate a controller, a function within and its corresponding view:
```
rails generate controller welcome index
```

Now, open the file config/routes.rb in your editor and uncomment the following line:
```
root 'welcome#index'
```





--------

## License

This sample is licensed under the terms of the [MIT License](http://opensource.org/licenses/MIT). Please see the [LICENSE](LICENSE) file for full details.


## Written by

Pratham Makhni Alag (Autodesk Developer Network)<br />
http://www.autodesk.com/adn<br />


For troubleshooting, visit forums.autodesk.com and post with reference to the view and data api.
