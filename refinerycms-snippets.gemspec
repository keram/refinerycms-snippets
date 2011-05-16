  Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-snippets'
  s.version           = '0.4.0'
  s.description       = 'Ruby on Rails Snippets engine for Refinery CMS'
  s.date              = '2011-05-17'
  s.summary           = 'Html snippets for Refinery CMS page'
  s.authors           = ["Marek L."]
  s.email             = %q{nospam.keram@gmail.com}
  s.require_paths     = %w(lib)
  s.files             = Dir['lib/**/*', 'config/**/*', 'app/**/*', 'db/**/*', 'public/**/*']
  
  s.add_dependency    'refinerycms-pages', '>= 0.9.9.1'
end
