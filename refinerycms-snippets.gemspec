# Encoding: UTF-8

require 'date'
require File.expand_path('../lib/refinery/snippets/version', __FILE__)

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-snippets'
  s.version           = Refinery::Snippets::Version.to_s
  s.description       = %q{Ruby on Rails Snippets engine for Refinery CMS}
  s.date              = Date.today.strftime("%Y-%m-%d")
  s.summary           = %q{Html snippets for Refinery CMS page}
  s.authors           = ['Marek L.', 'Rodrigo Garcia Suarez']
  s.email             = 'nospam.keram@gmail.com'
  s.homepage          = 'https://www.github.com/keram/refinerycms-inquiries2'
  s.require_paths     = %w(lib)
  s.files             = `git ls-files -- app/* lib/*`.split("\n")

  # Runtime dependencies
  s.add_dependency    'refinerycms-core',     '~> 2.718.0.dev'
end
