require "application_system_test_case"

class UserFeedsTest < ApplicationSystemTestCase
  setup do
    @user_feed = user_feeds(:one)
  end

  test "visiting the index" do
    visit user_feeds_url
    assert_selector "h1", text: "User Feeds"
  end

  test "creating a User feed" do
    visit user_feeds_url
    click_on "New User Feed"

    click_on "Create User feed"

    assert_text "User feed was successfully created"
    click_on "Back"
  end

  test "updating a User feed" do
    visit user_feeds_url
    click_on "Edit", match: :first

    click_on "Update User feed"

    assert_text "User feed was successfully updated"
    click_on "Back"
  end

  test "destroying a User feed" do
    visit user_feeds_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User feed was successfully destroyed"
  end
end
