require 'test_helper'

class CashInsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cash_in = cash_ins(:one)
  end

  test "should get index" do
    get cash_ins_url
    assert_response :success
  end

  test "should get new" do
    get new_cash_in_url
    assert_response :success
  end

  test "should create cash_in" do
    assert_difference('CashIn.count') do
      post cash_ins_url, params: { cash_in: { description: @cash_in.description, method: @cash_in.method, origin: @cash_in.origin, value: @cash_in.value } }
    end

    assert_redirected_to cash_in_url(CashIn.last)
  end

  test "should show cash_in" do
    get cash_in_url(@cash_in)
    assert_response :success
  end

  test "should get edit" do
    get edit_cash_in_url(@cash_in)
    assert_response :success
  end

  test "should update cash_in" do
    patch cash_in_url(@cash_in), params: { cash_in: { description: @cash_in.description, method: @cash_in.method, origin: @cash_in.origin, value: @cash_in.value } }
    assert_redirected_to cash_in_url(@cash_in)
  end

  test "should destroy cash_in" do
    assert_difference('CashIn.count', -1) do
      delete cash_in_url(@cash_in)
    end

    assert_redirected_to cash_ins_url
  end
end
