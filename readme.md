# Snippets engine for Refinery CMS.

## About

Snippets allows you to relate one or more html blocks to any page in Refinery.

## Requirements

* RefineryCMS with 'Pages' engine (refinerycms-pages >= 0.9.9.1)

## TODO

### to 1.0
* Snippet selector in page administration. -- done
* Save and Continue button 
* Documentation
* Tests 

### to 2.0
* custom attributes for snippet (id, classes etc)
* support for dynamic snippets (erb templates, forms etc)
* improve UI 
* inheritance and clone 

## Install

Add this line to your applications `Gemfile`

    gem 'refinerycms-snippets', '~> 0.3.1'

Next run

    bundle install
    rails g refinerycms_snippets
    rake db:migrate

## Usage

* Create Snippet on /refinery/snippets
* Now you can attach snippet to page when you click Edit this page on `/refinery/pages`
* Next add something like this to: 

`app/views/pages/show.html.erb`

	<% content_for :body_content_right do %>
	  <% @page.snippets.each do |s| %>
	    <%= raw s.body %>
	  <% end %>
	<% end %>
	<%= render :partial => "/shared/content_page" %>

## Screenshots

![Create/Edit Snippet] (http://farm3.static.flickr.com/2150/5702424159_a688bfd7dd_b.jpg)
![Snippets Administration] (http://farm3.static.flickr.com/2018/5702979460_3126471546_b.jpg)

## Donate

Feel free buy me some gift ;-)
http://www.amazon.com/gp/registry/wishlist/1BBMUW9DDYXFF
