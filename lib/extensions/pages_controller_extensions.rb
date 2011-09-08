module Extensions
  module PagesController

    def self.included(base)

      base.class_eval do
        after_filter :render_snippets, :only => [:show, :home]

        def render_snippets
          if @page
            @page.snippets.each do |snippet|
              response.body = response.body.gsub(snippet.template_filename, render_to_string(:file => snippet.template_path, :layout => false)) if snippet.template?
            end
          end
        end

      end

    end

  end
end
