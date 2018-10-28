class Comment < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :resource, touch: true

  validates_presence_of :name
  validates_length_of :name, minimum: 2, maximum: 100
  validates_presence_of :comment
  validates_length_of :comment, maximum: APP_SETTINGS['max_comment_length']
end
