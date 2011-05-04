# Snippets engine for Refinery CMS.

## About

Snippets allows you to relate one or more html blocks to any page in Refinery.

## Requirements

* refinerycms >= 0.9.9

## TODO

### to 1.0
* Snippet selector in page administration.
* Documentation

## Install

Add this line to your applications `Gemfile`

    gem 'refinerycms-snippets', '~> 0.1'

Next run

    bundle install
    rails g refinerycms_snippets
    rake db:migrate

## Usage

`app/views/pages/show.html.erb`

	<% content_for :body_content_right do %>
	  <% @page.snippets.each do |s| %>
	    <%= raw s.body %>
	  <% end %>
	<% end %>
	<%= render :partial => "/shared/content_page" %>
