class Api::V1::ServiceTicketsController < Api::V1::BaseController
  #skip_before_action :set_driver
  def me
  	@service_tickets = @cur_driver.todays_service_tickets.includes(:client)
    render(json: @service_tickets.to_json( include: [:client]))
  end

  def show
    @service_ticket = @cur_driver.service_tickets.where(id: params[:id]).includes(:client)
    render(json: @service_ticket.to_json( include: [:client]))
  end

  def update_service_ticket
  	@ticket = @cur_driver.service_tickets.find(params[:id])
  	if params[:type] == "pickup"
  		@ticket.pickup_time = Time.now
  	elsif params[:type] == "dropoff"
  		@ticket.dropoff_time = Time.now
  	else
  		render(json: @ticket)
  		return
  	end
  	@ticket.save
  	render(json: @ticket)
  end

  def signature
      ticket = ServiceTicket.find(params[:id])
      ticket.signature = upload_params[:value]
      ticket.save!
    ensure
      clean_tempfile
  end

  private

  def upload_params
    the_params = params.permit(:value)
    the_params[:value] = parse_image_data(the_params[:value]) if the_params[:value]
    the_params
  end

  def parse_image_data(base64_image)
    filename = "upload-image"
    in_content_type, encoding, string = base64_image.split(/[:;,]/)[1..3]

    @tempfile = Tempfile.new(filename)
    @tempfile.binmode
    @tempfile.write Base64.decode64(string)
    @tempfile.rewind

    # for security we want the actual content type, not just what was passed in
    content_type = `file --mime -b #{@tempfile.path}`.split(";")[0]

    # we will also add the extension ourselves based on the above
    # if it's not gif/jpeg/png, it will fail the validation in the upload model
    extension = content_type.match(/gif|jpeg|png/).to_s
    filename += ".#{extension}" if extension

    ActionDispatch::Http::UploadedFile.new({
      tempfile: @tempfile,
      content_type: content_type,
      filename: filename
    })
  end

  def clean_tempfile
    if @tempfile
      @tempfile.close
      @tempfile.unlink
    end
  end

end
