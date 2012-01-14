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
        def content_of(page, part_title, yield_body=nil)
          part = page.parts.detect do |part|
            part.title.present? and #protecting against the problem that occurs when have nil title
            title(part.title) == part_title
          end

          if part
            content = ""
            content += part.snippets.before.map{|snippet| render_snippet(snippet)}.join
            content += part.body if part.try(:body).present?
            content += yield_body if yield_body.present?
            content += part.snippets.after.map{|snippet| render_snippet(snippet)}.join
          end
        end

        private

        def title(title)
          case (title_symbol = title.to_s.gsub(/\ /, '').underscore.to_sym)
            when :body then :body_content_left
            when :side_body then :body_content_right
            else title_symbol
          end
        end

        def render_snippet(snippet)
          title_slug = snippet.title.to_s.gsub(/\s/, "_").gsub(/[^-\w]/, "").downcase
          begin
            render :partial => "snippets/#{title_slug}"
          rescue ActionView::MissingTemplate
            snippet.try(:body)
          end
        end

      end
    end

  end
end
