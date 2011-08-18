module Extensions

  module Page

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

      content = part.snippets.before.each{|snippet| snippet.try(:body)}
      content = part.try(:body)
      content = part.snippets.after.each{|snippet| snippet.try(:body)}
    end

    def self.included(base)
      alias_method :content_without_snippets_for, :content_for
    end

  end

end
