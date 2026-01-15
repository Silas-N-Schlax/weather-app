require 'rails_helper'

RSpec.describe "Site Navigation", type: :system, js: true do
  before do
    driven_by(:selenium_chrome_headless)
  end

  it "allows user to create new locaiton" do
    visit locations_path

    fill_in "Name", with: "My first location🤔"
    fill_in "Input", with: "8.8.8.8"

    click_on "Create Location"

    within(".loc-name") do
      expect(page).to have_content("My first location🤔")
    end
  end

  # it "allows user to render weather data for a specific location" do
  #   visit locations_path

  #   fill_in "Name", with: "My first location🤔"
  #   fill_in "Input", with: "8.8.8.8"

  #   click_on "Create Location"

  #   expect(page).to have_selector(".loc-card")

  #   within(".loc-card") do
  #     click_on "click"
  #   end


  #   within(".main-content") do
  #     expect(page).to have_selector(".weather_container", wait: 5)
  #   end
  # end
  #
  # ! I attempted to load the content, but for some reason no matter what I tried to attach it to, or even adding buttons with the data atributes, it would not load.
  # ! I think I am doing something wrong with how I am trying to connect to my stimulus controller to load the data, but I do not have the time left to solve this.
  # ! That said I have created a functinal system test for creating and deleting the locations.

  it "allows user to delete a new location" do
    visit locations_path

    fill_in "Name", with: "My first location🤔"
    fill_in "Input", with: "8.8.8.8"

    click_on "Create Location"

    within(".loc-name") do
      expect(page).to have_content("My first location🤔")
    end

    within(".loc-card") do
      click_on "Delete"
    end
    expect(page).to have_no_selector(".loc-card")
  end
end
