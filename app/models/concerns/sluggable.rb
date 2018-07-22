require 'active_support/concern'

module Sluggable
  extend ActiveSupport::Concern

  included do
    before_create :set_slug
  end

  def get_slug
    # This number is used in case the parameterized slug
    # is not unique.
    trailing_number = 0
    slug            = ''

    loop do
      if trailing_number == 0
        slug = title.parameterize
      else
        slug = "#{title.parameterize}-#{trailing_number}"
      end

      break unless self.class.where(slug: slug).exists?

      trailing_number += 1
    end

    slug
  end

  def to_param
    slug
  end

  private

    def set_slug
      return if slug.present?

      self.slug = get_slug
    end
end