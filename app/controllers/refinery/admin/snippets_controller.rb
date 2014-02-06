module ::Refinery
  module Admin
    class SnippetsController < ::Refinery::AdminController

      crudify :'refinery/snippet'

      def snippet_params
        params.require(:snippet).permit([:title, :body])
      end

    end
  end
end
