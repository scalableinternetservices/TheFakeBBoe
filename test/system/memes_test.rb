require "application_system_test_case"

class MemesTest < ApplicationSystemTestCase
  setup do
    # @meme = memes(:one)
  end

  test "visiting the index" do
    visit memes_url
    assert_selector "h1", text: "Memes"
  end

  test "creating a Meme" do
    visit memes_url
    click_on "New Meme"

    click_on "Create Meme"

    assert_text "Meme was successfully created"
    click_on "Back"
  end

  test "updating a Meme" do
    visit memes_url
    click_on "Edit", match: :first

    click_on "Update Meme"

    assert_text "Meme was successfully updated"
    click_on "Back"
  end

  test "destroying a Meme" do
    visit memes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Meme was successfully destroyed"
  end
end
