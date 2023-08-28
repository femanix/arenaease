require "application_system_test_case"

class TeamAccountsTest < ApplicationSystemTestCase
  setup do
    @team_account = team_accounts(:one)
  end

  test "visiting the index" do
    visit team_accounts_url
    assert_selector "h1", text: "Team Accounts"
  end

  test "creating a Team account" do
    visit team_accounts_url
    click_on "New Team Account"

    fill_in "Balance cents", with: @team_account.balance_cents
    fill_in "Team", with: @team_account.team_id
    click_on "Create Team account"

    assert_text "Team account was successfully created"
    click_on "Back"
  end

  test "updating a Team account" do
    visit team_accounts_url
    click_on "Edit", match: :first

    fill_in "Balance cents", with: @team_account.balance_cents
    fill_in "Team", with: @team_account.team_id
    click_on "Update Team account"

    assert_text "Team account was successfully updated"
    click_on "Back"
  end

  test "destroying a Team account" do
    visit team_accounts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Team account was successfully destroyed"
  end
end
