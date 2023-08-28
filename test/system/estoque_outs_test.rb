require "application_system_test_case"

class EstoqueOutsTest < ApplicationSystemTestCase
  setup do
    @estoque_out = estoque_outs(:one)
  end

  test "visiting the index" do
    visit estoque_outs_url
    assert_selector "h1", text: "Estoque Outs"
  end

  test "creating a Estoque out" do
    visit estoque_outs_url
    click_on "New Estoque Out"

    fill_in "Admin", with: @estoque_out.admin_id
    fill_in "Produto", with: @estoque_out.produto_id
    fill_in "Quantidade", with: @estoque_out.quantidade
    click_on "Create Estoque out"

    assert_text "Estoque out was successfully created"
    click_on "Back"
  end

  test "updating a Estoque out" do
    visit estoque_outs_url
    click_on "Edit", match: :first

    fill_in "Admin", with: @estoque_out.admin_id
    fill_in "Produto", with: @estoque_out.produto_id
    fill_in "Quantidade", with: @estoque_out.quantidade
    click_on "Update Estoque out"

    assert_text "Estoque out was successfully updated"
    click_on "Back"
  end

  test "destroying a Estoque out" do
    visit estoque_outs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Estoque out was successfully destroyed"
  end
end
