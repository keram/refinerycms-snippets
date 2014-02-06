module Refinery
  class Snippet < ActiveRecord::Base

    TYPES = ['text', 'template']

    validates :title, presence: true, uniqueness: true

    translates :title, :body

    def title
      return self[:title] if self[:title].present?
      translation = translations.detect {|t| t.title.present? }
      translation.title if translation
    end
  end
end
