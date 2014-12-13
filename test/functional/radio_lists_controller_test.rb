require 'test_helper'

class RadioListsControllerTest < ActionController::TestCase
  setup do
    @radio_list = radio_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:radio_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create radio_list" do
    assert_difference('RadioList.count') do
      post :create, radio_list: {  }
    end

    assert_redirected_to radio_list_path(assigns(:radio_list))
  end

  test "should show radio_list" do
    get :show, id: @radio_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @radio_list
    assert_response :success
  end

  test "should update radio_list" do
    put :update, id: @radio_list, radio_list: {  }
    assert_redirected_to radio_list_path(assigns(:radio_list))
  end

  test "should destroy radio_list" do
    assert_difference('RadioList.count', -1) do
      delete :destroy, id: @radio_list
    end

    assert_redirected_to radio_lists_path
  end
end
