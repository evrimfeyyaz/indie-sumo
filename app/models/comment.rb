class Comment < ApplicationRecord
  belongs_to :resource

  validates_presence_of :name
  validates_length_of :name, minimum: 2, maximum: 100
  validates_presence_of :comment
  validates_length_of :comment, maximum: APP_SETTINGS['max_comment_length']
end
