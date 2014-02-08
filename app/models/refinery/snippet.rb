module Refinery
  class Snippet < ActiveRecord::Base
    extend GlobalizeFinder

    TYPES = ['text', 'template']

    validates :title, presence: true, uniqueness: true

    translates :title, :body

    before_save :create_canonical_friendly_id

    def title
      return self[:title] if self[:title].present?
      translation = translations.detect {|t| t.title.present? }
      translation.title if translation
    end

    private

    def create_canonical_friendly_id
      self.canonical_friendly_id = (canonical_friendly_id.presence || title.presence).parameterize
    end
  end
end
