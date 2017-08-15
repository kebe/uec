require 'test_helper'

class ServiceTicketsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @service_ticket = service_tickets(:one)
  end

  test "should get index" do
    get service_tickets_url
    assert_response :success
  end

  test "should get new" do
    get new_service_ticket_url
    assert_response :success
  end

  test "should create service_ticket" do
    assert_difference('ServiceTicket.count') do
      post service_tickets_url, params: { service_ticket: { client_id: @service_ticket.client_id, driver_id: @service_ticket.driver_id, dropoff_address: @service_ticket.dropoff_address, dropoff_time: @service_ticket.dropoff_time, pickup_address: @service_ticket.pickup_address, pickup_time: @service_ticket.pickup_time, service_date: @service_ticket.service_date, service_time: @service_ticket.service_time } }
    end

    assert_redirected_to service_ticket_url(ServiceTicket.last)
  end

  test "should show service_ticket" do
    get service_ticket_url(@service_ticket)
    assert_response :success
  end

  test "should get edit" do
    get edit_service_ticket_url(@service_ticket)
    assert_response :success
  end

  test "should update service_ticket" do
    patch service_ticket_url(@service_ticket), params: { service_ticket: { client_id: @service_ticket.client_id, driver_id: @service_ticket.driver_id, dropoff_address: @service_ticket.dropoff_address, dropoff_time: @service_ticket.dropoff_time, pickup_address: @service_ticket.pickup_address, pickup_time: @service_ticket.pickup_time, service_date: @service_ticket.service_date, service_time: @service_ticket.service_time } }
    assert_redirected_to service_ticket_url(@service_ticket)
  end

  test "should destroy service_ticket" do
    assert_difference('ServiceTicket.count', -1) do
      delete service_ticket_url(@service_ticket)
    end

    assert_redirected_to service_tickets_url
  end
end
