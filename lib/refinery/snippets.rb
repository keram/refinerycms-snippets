require 'refinerycms-pages'

module Refinery
  autoload :SnippetsGenerator, 'generators/refinery/snippets_generator'

  module Snippets
    require 'refinery/snippets/engine' if defined?(Rails)

    autoload :Version, 'refinery/snippets/version'
    autoload :Tab, 'refinery/snippets/tabs'

    class << self
      attr_accessor :root
      attr_writer :tabs

      def root
        @root ||= Pathname.new(File.expand_path('../../', __FILE__))
      end

      def tabs
        @tabs ||= []
      end

      def version
        ::Refinery::Blog::Version.to_s
      end
    end
  end
end