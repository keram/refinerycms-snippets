Refinery::Pages::PagePartSectionPresenter.class_eval do
  def has_content?
    super || before_content.present? || after_content.present?
  end

  def wrapped_html
    content_tag(:div,
      content_tag(:div,
        before_content + main_content + after_content,
        class: 'inner'),
      id: wrapper_id,
      class: wrapper_class
    ) if visible? && has_content?
  end

  private

  def before_content
    @before_content ||= ActiveSupport::SafeBuffer.new.tap do |buffer|
      @page_part.before_snippets_with_globalize.each do |snippet|
        buffer << snippet.render(@context)
      end
    end
  end

  def after_content
    @after_content ||= ActiveSupport::SafeBuffer.new.tap do |buffer|
      @page_part.after_snippets_with_globalize.each do |snippet|
        buffer << snippet.render(@context)
      end
    end
  end
end
