class ListItem < ApplicationRecord
  belongs_to :listable, polymorphic: true
  belongs_to :list

  # TODO: Make updated_at point to the most recent of own and listable's.
end