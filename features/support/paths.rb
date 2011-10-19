module NavigationHelpers
  module Refinery
    module Snippets
      def path_to(page_name)
        case page_name
        when /the list of snippets/
          refinery_admin_snippets_path

         when /the new snippet form/
          new_refinery_admin_snippet_path
        else
          nil
        end
      end
    end
  end
end
