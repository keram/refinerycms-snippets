module Extensions
  module ApplicationHelper

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
            content += part.snippets.before.map{|snippet| snippet.try(:body)}.join
            part_body = part.try(:body)
            content += part_body unless part_body.nil?
            content += part.snippets.after.map{|snippet| snippet.try(:body)}.join
          end
        end

      end
    end

  end
end
