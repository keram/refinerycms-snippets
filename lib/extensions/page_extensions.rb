module Extensions
  module Page

    def self.included(base)

      base.class_eval do

        scope :for_snippet, lambda{ |snippet|
          raise RuntimeError.new("Couldn't find Pages for a nil Snippet") if snippet.blank?
          {
            :joins => [:snippets_page_parts, :snippets],
            :conditions => {:snippets_page_parts => {:snippet_id => snippet.id}}
          }
        }

        def snippets
          Snippet.for_page(self)
        end

      end

    end

  end
end
