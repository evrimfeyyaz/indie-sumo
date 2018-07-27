require 'rails_helper'

describe Comment do
  it { should belong_to(:resource) }

  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(2).is_at_most(100) }
  it { should validate_presence_of(:comment) }
  it { should validate_length_of(:comment).is_at_most(APP_SETTINGS['max_comment_length']) }
end
