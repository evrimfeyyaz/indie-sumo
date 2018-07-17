class ListItem < ApplicationRecord
  belongs_to :listable, polymorphic: true
  belongs_to :list
end