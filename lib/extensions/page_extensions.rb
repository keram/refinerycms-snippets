module Extensions
  module Page

    def self.included(base)

      base.class_eval do

        named_scope :for_snippet, lambda{ |snippet|
          raise RuntimeError.new("Couldn't find Pages for a nil Snippet") if snippet.blank?
          {
            :joins => {:parts, :snippets},
            :conditions => {:snippets_page_parts => {:snippet_id => snippet.id}}
          }
        }

        alias_method :content_without_snippets_for, :content_for
        # Accessor method to get a page part from a page.
        # Example:
        #
        #    Page.first.content_for(:body)
        #
        # Will return the body page part of the first page wrap with its
        # attached snippets.
        def content_for(part_title)
          part = self.parts.detect do |part|
            part.title.present? and #protecting against the problem that occurs when have nil title
              part.title == part_title.to_s or
              part.title.downcase.gsub(" ", "_") == part_title.to_s.downcase.gsub(" ", "_")
          end

          content = ""
          content += part.snippets.before.map{|snippet| snippet.try(:content)}.join
          part_body = part.try(:body)
          content += part.try(:body) unless part_body.nil?
          content += part.snippets.after.map{|snippet| snippet.try(:content)}.join
        end

        def snippets
          Snippet.for_page(self)
        end

      end

    end

  end
end
