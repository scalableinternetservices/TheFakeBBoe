require "application_system_test_case"

class UserFeedSubscriptionsTest < ApplicationSystemTestCase
  setup do
    @user_feed_subscription = user_feed_subscriptions(:one)
  end

  test "visiting the index" do
    visit user_feed_subscriptions_url
    assert_selector "h1", text: "User Feed Subscriptions"
  end

  test "creating a User feed subscription" do
    visit user_feed_subscriptions_url
    click_on "New User Feed Subscription"

    click_on "Create User feed subscription"

    assert_text "User feed subscription was successfully created"
    click_on "Back"
  end

  test "updating a User feed subscription" do
    visit user_feed_subscriptions_url
    click_on "Edit", match: :first

    click_on "Update User feed subscription"

    assert_text "User feed subscription was successfully updated"
    click_on "Back"
  end

  test "destroying a User feed subscription" do
    visit user_feed_subscriptions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User feed subscription was successfully destroyed"
  end
end
