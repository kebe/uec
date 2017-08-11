class Api::V1::RoutesController < Api::V1::BaseController
  def index
    route = Route.includes( :driver, clients: [:operations]).first
    render(json: route.to_json( include: [:driver, :clients => {include: [:operations]}] ))
  end
  def show
    route = @cur_driver.routes.includes( driver: [:routes], clients: [:operations]).where(id: params[:id]).first
    render(json: route.to_json( include: [ {:clients => {include: [:operations]}}, {:driver => {include: [:routes]}}] ))
  end

end



