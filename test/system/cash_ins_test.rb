require "application_system_test_case"

class CashInsTest < ApplicationSystemTestCase
  setup do
    @cash_in = cash_ins(:one)
  end

  test "visiting the index" do
    visit cash_ins_url
    assert_selector "h1", text: "Cash Ins"
  end

  test "creating a Cash in" do
    visit cash_ins_url
    click_on "New Cash In"

    fill_in "Description", with: @cash_in.description
    fill_in "Method", with: @cash_in.method
    fill_in "Origin", with: @cash_in.origin
    fill_in "Value", with: @cash_in.value
    click_on "Create Cash in"

    assert_text "Cash in was successfully created"
    click_on "Back"
  end

  test "updating a Cash in" do
    visit cash_ins_url
    click_on "Edit", match: :first

    fill_in "Description", with: @cash_in.description
    fill_in "Method", with: @cash_in.method
    fill_in "Origin", with: @cash_in.origin
    fill_in "Value", with: @cash_in.value
    click_on "Update Cash in"

    assert_text "Cash in was successfully updated"
    click_on "Back"
  end

  test "destroying a Cash in" do
    visit cash_ins_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cash in was successfully destroyed"
  end
end
