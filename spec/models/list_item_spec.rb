require 'rails_helper'

describe ListItem do
  it { should belong_to(:listable) }
  it { should belong_to(:list) }
end
