class Api::V1::RoutesController < Api::V1::BaseController
  def index
    route = Route.includes(clients: [:operations]).first
    render(json: route.to_json( include: [:clients => {include: [:operations]}] ))
  end

end



