class ListItem < ApplicationRecord
  belongs_to :listable, polymorphic: true, touch: true
  belongs_to :list, touch: true
end