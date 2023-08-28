require "application_system_test_case"

class EstoqueInsTest < ApplicationSystemTestCase
  setup do
    @estoque_in = estoque_ins(:one)
  end

  test "visiting the index" do
    visit estoque_ins_url
    assert_selector "h1", text: "Estoque Ins"
  end

  test "creating a Estoque in" do
    visit estoque_ins_url
    click_on "New Estoque In"

    fill_in "Admin", with: @estoque_in.admin_id
    fill_in "Fornecedor", with: @estoque_in.fornecedor_id
    fill_in "Produto", with: @estoque_in.produto_id
    fill_in "Quantidade", with: @estoque_in.quantidade
    fill_in "Valor", with: @estoque_in.valor
    click_on "Create Estoque in"

    assert_text "Estoque in was successfully created"
    click_on "Back"
  end

  test "updating a Estoque in" do
    visit estoque_ins_url
    click_on "Edit", match: :first

    fill_in "Admin", with: @estoque_in.admin_id
    fill_in "Fornecedor", with: @estoque_in.fornecedor_id
    fill_in "Produto", with: @estoque_in.produto_id
    fill_in "Quantidade", with: @estoque_in.quantidade
    fill_in "Valor", with: @estoque_in.valor
    click_on "Update Estoque in"

    assert_text "Estoque in was successfully updated"
    click_on "Back"
  end

  test "destroying a Estoque in" do
    visit estoque_ins_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Estoque in was successfully destroyed"
  end
end
