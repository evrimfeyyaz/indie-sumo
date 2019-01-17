require 'rails_helper'

describe 'Comment management' do
  let(:resource) { create(:resource) }

  scenario 'User visits a resource page and adds a comment' do
    visit resource_path(resource)

    name    = 'John Doe'
    email   = 'john@example.com'
    comment = 'Some test comment.'

    expect do
      within '#comment-form' do
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

    expect(page).not_to have_text(comment)
  end

  scenario 'User visits a resource page with an approved comments' do
    comment1 = create(:comment, comment: 'Comment 1', resource: resource, approved: true)
    comment2 = create(:comment, comment: 'Comment 2', resource: resource, approved: true)

    visit resource_path(resource)

    # Check if relevant comment information is shown.
    expect(page).to have_text(comment1.name)
    expect(page).to have_text(comment1.comment)
    expect(page).not_to have_text(comment1.email)

    # Make sure they are sorted by date.
    expect(page).to have_css('#comments',
                             text: /#{Regexp.escape(comment2.comment)}.+#{Regexp.escape(comment1.comment)}/,
                             visible: false)
  end
end