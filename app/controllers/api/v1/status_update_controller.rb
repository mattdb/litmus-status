class Api::V1::StatusUpdateController < Api::V1::ApiController
  def create

    creator = CreatesStatusUpdate.new(
      status: params[:status],
      message: params[:message]
    )
    creator.create
    if creator.success?
      render plain: "OK", status: 200
    else
      render plain: creator.error, status: 400
    end
  end
end
