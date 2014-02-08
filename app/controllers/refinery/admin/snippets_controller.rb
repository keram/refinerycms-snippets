module Refinery
  module Admin
    class SnippetsController < ::Refinery::AdminController

      crudify :'refinery/snippet'

      def snippet_params
        params.require(:snippet).permit([:title, :body, :canonical_friendly_id])
      end

      def redirect_url
        if @snippet && @snippet.persisted?
          refinery.edit_admin_snippet_path(@snippet.id,
            locale: params[:switch_frontend_locale].presence || Globalize.locale)
        else
          refinery.admin_snippets_path
        end
      end

    end
  end
end
