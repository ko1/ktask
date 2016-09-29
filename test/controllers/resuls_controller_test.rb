require 'test_helper'

class ResulsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @resul = resuls(:one)
  end

  test "should get index" do
    get resuls_url
    assert_response :success
  end

  test "should get new" do
    get new_resul_url
    assert_response :success
  end

  test "should create resul" do
    assert_difference('Resul.count') do
      post resuls_url, params: { resul: {  } }
    end

    assert_redirected_to resul_url(Resul.last)
  end

  test "should show resul" do
    get resul_url(@resul)
    assert_response :success
  end

  test "should get edit" do
    get edit_resul_url(@resul)
    assert_response :success
  end

  test "should update resul" do
    patch resul_url(@resul), params: { resul: {  } }
    assert_redirected_to resul_url(@resul)
  end

  test "should destroy resul" do
    assert_difference('Resul.count', -1) do
      delete resul_url(@resul)
    end

    assert_redirected_to resuls_url
  end
end
