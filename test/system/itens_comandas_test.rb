require "application_system_test_case"

class ItensComandasTest < ApplicationSystemTestCase
  setup do
    @itens_comanda = itens_comandas(:one)
  end

  test "visiting the index" do
    visit itens_comandas_url
    assert_selector "h1", text: "Itens Comandas"
  end

  test "creating a Itens comanda" do
    visit itens_comandas_url
    click_on "New Itens Comanda"

    fill_in "Comanda", with: @itens_comanda.comanda_id
    fill_in "Produto", with: @itens_comanda.produto_id
    fill_in "Quantidade", with: @itens_comanda.quantidade
    fill_in "Valor", with: @itens_comanda.valor
    click_on "Create Itens comanda"

    assert_text "Itens comanda was successfully created"
    click_on "Back"
  end

  test "updating a Itens comanda" do
    visit itens_comandas_url
    click_on "Edit", match: :first

    fill_in "Comanda", with: @itens_comanda.comanda_id
    fill_in "Produto", with: @itens_comanda.produto_id
    fill_in "Quantidade", with: @itens_comanda.quantidade
    fill_in "Valor", with: @itens_comanda.valor
    click_on "Update Itens comanda"

    assert_text "Itens comanda was successfully updated"
    click_on "Back"
  end

  test "destroying a Itens comanda" do
    visit itens_comandas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Itens comanda was successfully destroyed"
  end
end
