# Snippets engine for Refinery CMS.

## About

Snippets allows you to relate one or more html blocks or erb templates to any page in Refinery. These are attached to the page parts, before or after the its html body.

## Requirements

* RefineryCMS with 'Pages' engine (refinerycms-pages >= 2.0.0)

## TODO

### to 1.0
* Snippet selector in page administration. -- done
* Save and Continue button -- done
* Attaching snippet to page part directly through administration, without overriding view template -- done
* Documentation
* Tests 

### to 2.0
* custom attributes for snippet (id, classes etc)
* support for dynamic snippets (erb templates, forms etc) -- done
* improve UI 
* inheritance and clone 

## Install

Add this line to your applications `Gemfile`

    gem 'refinerycms-snippets', '~> 2.0.0'

Next run

    bundle install
    rails g refinerycms:snippets
    rake db:migrate

## Usage

* Create Snippet on /refinery/snippets
* Now you can attach snippet to page when you click Edit this page on `/refinery/pages`. In the Snippets tab you can select the part to which you want to attach the block and add it after and/or before the html body of the part.  
* Next you can use content_of(@page, :part) to print the body of the part and the snippets attached to it in the pages views.
* You have some other interesting methods to work with snippets:
  * content_or_render_of(snippet): will return the content body (or erb template) of the snippet. 
  * page.snippets: returns all the snippets attached to all the parts of page.
  * snippet.pages: returns all pages to whose parts is snippet attached.
  * snippet.before?(part): returns true if snippet is attached before part body.
  * snippet.after?(part): return true if snippet is attached after part body.

## ERB templates usage

Snippets search for templates in RAILS_VIEWS_PATH/shared/snippets. The snippet searchs for a file with its same name but with all non A-Za-z0-9 characters changed to underscores. If this file exists, snippet html body is ignored and the template is rendered in its place. Methods rendering the template, if exists, in place of the body are content_of(@page, :part) and content_or_render_of(snippet).

For example, a template with title "VIP clients: photos" would search in "app/views/shared/snippets" for a file named "vip_clients_photos.html.erb"; "Country & region banners: España" for "country_region_banners_espa_na" and so on.

Templates are normal erb files. If you want to add complex logic to them I suggest the use of [Cells](http://cells.rubyforge.org/).

## Screenshots

![Create/Edit Snippet] (http://farm3.static.flickr.com/2150/5702424159_a688bfd7dd_b.jpg)

## Donate

Feel free buy me some gift ;-)
http://www.amazon.com/gp/registry/wishlist/1BBMUW9DDYXFF
