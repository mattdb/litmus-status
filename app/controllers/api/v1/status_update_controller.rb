class Api::V1::StatusUpdateController < ApplicationController
  # Not calling from browser, so CSRF protection not useful
  # Real world would have actual authentication/authorization logic to prevent unfettered use
  skip_forgery_protection

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
