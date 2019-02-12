require 'rails_helper'

describe ListItem do
  it { should belong_to(:listable).touch(true) }
  it { should belong_to(:list).touch(true) }
end
