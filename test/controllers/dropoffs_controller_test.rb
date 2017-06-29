require 'test_helper'

class DropoffsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dropoff = dropoffs(:one)
  end

  test "should get index" do
    get dropoffs_url
    assert_response :success
  end

  test "should get new" do
    get new_dropoff_url
    assert_response :success
  end

  test "should create dropoff" do
    assert_difference('Dropoff.count') do
      post dropoffs_url, params: { dropoff: { client_id: @dropoff.client_id, day: @dropoff.day, dropoff_date: @dropoff.dropoff_date, status: @dropoff.status } }
    end

    assert_redirected_to dropoff_url(Dropoff.last)
  end

  test "should show dropoff" do
    get dropoff_url(@dropoff)
    assert_response :success
  end

  test "should get edit" do
    get edit_dropoff_url(@dropoff)
    assert_response :success
  end

  test "should update dropoff" do
    patch dropoff_url(@dropoff), params: { dropoff: { client_id: @dropoff.client_id, day: @dropoff.day, dropoff_date: @dropoff.dropoff_date, status: @dropoff.status } }
    assert_redirected_to dropoff_url(@dropoff)
  end

  test "should destroy dropoff" do
    assert_difference('Dropoff.count', -1) do
      delete dropoff_url(@dropoff)
    end

    assert_redirected_to dropoffs_url
  end
end
