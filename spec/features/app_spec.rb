require "rspec"
require "capybara"

feature "Messages" do
  scenario "As a user, I can submit a message" do
    visit "/"

    expect(page).to have_content("Message Roullete")

    fill_in "Message", :with => "Hello Everyone!"

    click_button "Submit"

    expect(page).to have_content("Hello Everyone!")
  end

  scenario "As a user, I see an error message if I enter a message > 140 characters" do
    visit "/"

    fill_in "Message", :with => "a" * 141

    click_button "Submit"

    expect(page).to have_content("Message must be less than 140 characters.")
  end

  scenario "As a user, I can edit a message" do
    visit "/"

    expect(page).to have_content("Message Roullete")

    fill_in "Message", :with => "Hello Everyone!"

    click_button "Submit"

    expect(page).to have_content("Hello Everyone!")

    click_on "edit"

    expect(page).to have_content("Edit Message")

    fill_in "message", :with => "I said, Hello Everyone!"

    click_on "Edit"

    expect(page).to have_content("I said, Hello Everyone!")

    click_on "Delete"

    expect(page).to_not have_content("I said, Hello Everyone!")
  end

  scenario "As a user I can add a comment to a message" do
      visit "/"

      expect(page).to have_content("Message Roullete")

      fill_in "Message", :with => "Hello Everyone!"

      click_button "Submit"

      expect(page).to have_content("Hello Everyone!")

      click_on "edit"

      expect(page).to have_content("Edit Message")

      fill_in "message", :with => "I said, Hello Everyone!"

      click_on "Edit"

      expect(page).to have_content("I said, Hello Everyone!")

      click_on "Comment"

      expect(page).to have_content("Add a comment")

      fill_in "comment", :with => "Here is a comment"

      click_on "Add Comment"

      expect(page).to have_content "Here is a comment"


  end
end
