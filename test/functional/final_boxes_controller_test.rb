require 'test_helper'

class FinalBoxesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:final_boxes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create final_box" do
    assert_difference('FinalBox.count') do
      post :create, :final_box => { }
    end

    assert_redirected_to final_box_path(assigns(:final_box))
  end

  test "should show final_box" do
    get :show, :id => final_boxes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => final_boxes(:one).to_param
    assert_response :success
  end

  test "should update final_box" do
    put :update, :id => final_boxes(:one).to_param, :final_box => { }
    assert_redirected_to final_box_path(assigns(:final_box))
  end

  test "should destroy final_box" do
    assert_difference('FinalBox.count', -1) do
      delete :destroy, :id => final_boxes(:one).to_param
    end

    assert_redirected_to final_boxes_path
  end
end
