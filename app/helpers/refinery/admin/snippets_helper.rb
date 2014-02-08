module Refinery
  module Admin
    module SnippetsHelper

      def snippet_meta_information(snippet)
        meta_information = ActiveSupport::SafeBuffer.new
        meta_information << content_tag(:span, class: 'label') do
          ::I18n.t(snippet.snippet_type, scope: 'refinery.admin.snippets.snippet')
        end

        meta_information << content_tag(:span, class: 'label important') do
          ::I18n.t('untranslated', scope: 'refinery.admin.pages.page')
        end if snippet.translation.new_record?

        meta_information
      end

    end
  end
end
