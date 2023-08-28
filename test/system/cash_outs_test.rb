require "application_system_test_case"

class CashOutsTest < ApplicationSystemTestCase
  setup do
    @cash_out = cash_outs(:one)
  end

  test "visiting the index" do
    visit cash_outs_url
    assert_selector "h1", text: "Cash Outs"
  end

  test "creating a Cash out" do
    visit cash_outs_url
    click_on "New Cash Out"

    fill_in "Category", with: @cash_out.category
    fill_in "Description", with: @cash_out.description
    fill_in "Expiration", with: @cash_out.expiration
    fill_in "Method", with: @cash_out.method
    fill_in "Payment date", with: @cash_out.payment_date
    fill_in "Supplier", with: @cash_out.supplier
    fill_in "Value", with: @cash_out.value
    click_on "Create Cash out"

    assert_text "Cash out was successfully created"
    click_on "Back"
  end

  test "updating a Cash out" do
    visit cash_outs_url
    click_on "Edit", match: :first

    fill_in "Category", with: @cash_out.category
    fill_in "Description", with: @cash_out.description
    fill_in "Expiration", with: @cash_out.expiration
    fill_in "Method", with: @cash_out.method
    fill_in "Payment date", with: @cash_out.payment_date
    fill_in "Supplier", with: @cash_out.supplier
    fill_in "Value", with: @cash_out.value
    click_on "Update Cash out"

    assert_text "Cash out was successfully updated"
    click_on "Back"
  end

  test "destroying a Cash out" do
    visit cash_outs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cash out was successfully destroyed"
  end
end
