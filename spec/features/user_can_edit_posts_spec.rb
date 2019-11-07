require 'rails_helper'

RSpec.feature "Edit", type: :feature do
  scenario "Can edit posts" do
    visit('/')
    create_user
    login_user
    create_post
    click_link 'Edit'
    expect(page).to have_content('Edit Post')
  end

  scenario "Can edit posts and view them" do
    visit('/')
    create_user
    login_user
    create_post
    click_link 'Edit'
    fill_in "post[message]", with: "I am edited."
    click_button 'Update Post'
    expect(page).to have_content("I am edited.")
    expect(page).not_to have_content("Hello world")
  end

end