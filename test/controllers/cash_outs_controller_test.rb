require 'test_helper'

class CashOutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cash_out = cash_outs(:one)
  end

  test "should get index" do
    get cash_outs_url
    assert_response :success
  end

  test "should get new" do
    get new_cash_out_url
    assert_response :success
  end

  test "should create cash_out" do
    assert_difference('CashOut.count') do
      post cash_outs_url, params: { cash_out: { category: @cash_out.category, description: @cash_out.description, expiration: @cash_out.expiration, method: @cash_out.method, payment_date: @cash_out.payment_date, supplier: @cash_out.supplier, value: @cash_out.value } }
    end

    assert_redirected_to cash_out_url(CashOut.last)
  end

  test "should show cash_out" do
    get cash_out_url(@cash_out)
    assert_response :success
  end

  test "should get edit" do
    get edit_cash_out_url(@cash_out)
    assert_response :success
  end

  test "should update cash_out" do
    patch cash_out_url(@cash_out), params: { cash_out: { category: @cash_out.category, description: @cash_out.description, expiration: @cash_out.expiration, method: @cash_out.method, payment_date: @cash_out.payment_date, supplier: @cash_out.supplier, value: @cash_out.value } }
    assert_redirected_to cash_out_url(@cash_out)
  end

  test "should destroy cash_out" do
    assert_difference('CashOut.count', -1) do
      delete cash_out_url(@cash_out)
    end

    assert_redirected_to cash_outs_url
  end
end
