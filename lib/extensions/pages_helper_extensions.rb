module Extensions
  module PagesHelper

    def self.included(base)
      base.class_eval do

        ##
        # Accessor method to get a page part from a page.
        # Example:
        #
        #    content_of(Page.first, :body)
        #
        # Will return the body page part of the first page wrap with its
        # attached snippets.
        def content_of(page, part_title)
          part = page.parts.detect do |part|
            part.title.present? and #protecting against the problem that occurs when have nil title
              part.title == part_title.to_s or
              part.title.downcase.gsub(" ", "_") == part_title.to_s.downcase.gsub(" ", "_")
          end

          if part
            content = ""
            content += part.snippets.before.map{|snippet| content_or_render_of(snippet)}.join
            part_body = part.try(:body)
            content += part_body unless part_body.nil?
            content += part.snippets.after.map{|snippet| content_or_render_of(snippet)}.join
          end
        end

        def content_or_render_of(snippet)
          snippet.template? ? render(:file => snippet.template_path) : snippet.body
        end

      end
    end

  end
end
