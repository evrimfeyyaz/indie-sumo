require 'rails_helper'

feature 'Comment management' do
  let(:resource) { create(:resource) }

  scenario 'User visits a resource page and adds a comment' do
    visit resource_path(resource)

    name    = 'John Doe'
    email   = 'john@example.com'
    comment = 'Some test comment.'

    expect do
      within '.comment-form' do
        fill_in 'Name', with: name
        fill_in 'Email', with: email
        fill_in 'Comment', with: comment

        click_button 'Submit'
      end
    end.to change { resource.comments.count }.by(1)

    unapproved_comment = resource.comments.last
    expect(unapproved_comment.name).to eq(name)
    expect(unapproved_comment.email).to eq(email)
    expect(unapproved_comment.comment).to eq(comment)
  end
end