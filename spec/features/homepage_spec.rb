require 'rails_helper'

RSpec.feature "HomePage", type: :feature do

  it "Displays 'no updates' with empty updates table" do
    visit root_path

    expect(page).to have_content("No updates yet!")
  end

  it "Displays Status" do
    create(:status_update, is_up: true)

    visit root_path

    expect(page).to have_content("up")
  end

  it "Displays a recent message" do
    create(:status_update, message: "I can show messages!")

    visit root_path

    expect(page).to have_content("I can show messages!")
  end
end
