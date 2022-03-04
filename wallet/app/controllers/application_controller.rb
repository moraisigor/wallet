class ApplicationController < ActionController::API
  def error(error, status)
    render json: error, status: status
  end

  def success(any, status)
    render json: any, status: status
  end
end
