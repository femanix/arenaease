require "application_system_test_case"

class ComandasTest < ApplicationSystemTestCase
  setup do
    @comanda = comandas(:one)
  end

  test "visiting the index" do
    visit comandas_url
    assert_selector "h1", text: "Comandas"
  end

  test "creating a Comanda" do
    visit comandas_url
    click_on "New Comanda"

    fill_in "Cliente", with: @comanda.cliente_id
    fill_in "Forma pagamento", with: @comanda.forma_pagamento_id
    fill_in "Itens", with: @comanda.itens
    fill_in "Valor total", with: @comanda.valor_total
    click_on "Create Comanda"

    assert_text "Comanda was successfully created"
    click_on "Back"
  end

  test "updating a Comanda" do
    visit comandas_url
    click_on "Edit", match: :first

    fill_in "Cliente", with: @comanda.cliente_id
    fill_in "Forma pagamento", with: @comanda.forma_pagamento_id
    fill_in "Itens", with: @comanda.itens
    fill_in "Valor total", with: @comanda.valor_total
    click_on "Update Comanda"

    assert_text "Comanda was successfully updated"
    click_on "Back"
  end

  test "destroying a Comanda" do
    visit comandas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Comanda was successfully destroyed"
  end
end
