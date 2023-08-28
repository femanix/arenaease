require "application_system_test_case"

class FormaPagamentosTest < ApplicationSystemTestCase
  setup do
    @forma_pagamento = forma_pagamentos(:one)
  end

  test "visiting the index" do
    visit forma_pagamentos_url
    assert_selector "h1", text: "Forma Pagamentos"
  end

  test "creating a Forma pagamento" do
    visit forma_pagamentos_url
    click_on "New Forma Pagamento"

    fill_in "Descricao", with: @forma_pagamento.descricao
    click_on "Create Forma pagamento"

    assert_text "Forma pagamento was successfully created"
    click_on "Back"
  end

  test "updating a Forma pagamento" do
    visit forma_pagamentos_url
    click_on "Edit", match: :first

    fill_in "Descricao", with: @forma_pagamento.descricao
    click_on "Update Forma pagamento"

    assert_text "Forma pagamento was successfully updated"
    click_on "Back"
  end

  test "destroying a Forma pagamento" do
    visit forma_pagamentos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Forma pagamento was successfully destroyed"
  end
end
