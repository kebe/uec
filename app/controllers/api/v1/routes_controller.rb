class Api::V1::RoutesController < Api::V1::BaseController
  def index
    route = Route.includes(:clients).first
    render(json: route.to_json( include: [:clients] ))
  end

end



