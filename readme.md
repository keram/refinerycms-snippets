# Snippets engine for Refinery CMS.

## About

Snippets allows you to relate one or more html blocks to any page in Refinery. These blocks are attached to the page parts, before or after the its html body.

## Requirements

* RefineryCMS with 'Pages' engine (refinerycms-pages >= 0.9.9.1)

## TODO

### to 1.0
* Snippet selector in page administration. -- done
* Save and Continue button -- done
* Attaching snippet to page part directly through administration, without overriding view template -- done
* Documentation
* Tests

### to 2.0
* custom attributes for snippet (id, classes etc)
* support for dynamic snippets (erb templates, forms etc)
* improve UI
* inheritance and clone

## Install

Add this line to your applications `Gemfile`

    gem 'refinerycms-snippets', '~> 0.4.1'

Next run

    bundle install
    rails g refinerycms_snippets
    rake db:migrate

## Usage

* Create Snippet on /refinery/snippets
* Now you can attach snippet to page when you click Edit this page on `/refinery/pages`. In the Snippets tab you can select the part to which you want to attach the block and add it after and/or before the html body of the part.
* Next you can use content_of(@page, :part) or to print the body of the part and the snippets attached to it in the pages views.
* You can also use content_of(@page, :part, yield(:part)) for it to work with other engines such as blog and news
* You have some other interesting methods to work with snippets:
  * page.snippets: returns all the snippets attached to all the parts of page.
  * part.after: returns all the snippets attached after the html body of part.
  * part.before: returns all the snippets attached before the html body of part.
  * snippet.pages: returns all pages to whose parts is snippet attached.
  * snippet.before?(part): returns true if snippet is attached before part body.
  * snippet.after?(part): return true if snippet is attached after part body.

## Screenshots

![Create/Edit Snippet] (http://farm3.static.flickr.com/2150/5702424159_a688bfd7dd_b.jpg)

## Donate

Feel free buy me some gift ;-)
http://www.amazon.com/gp/registry/wishlist/1BBMUW9DDYXFF
