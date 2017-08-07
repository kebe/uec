class Api::V1::DriversController < Api::V1::BaseController

  def me
    @driver = Driver.includes(:routes).where(id: current_driver.id).first
    render(json: @driver.to_json( include: :routes))
  end

end