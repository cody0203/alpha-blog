class ApplicationController < ActionController::Base
  def pagination(data)
    data.paginate(page: params[:page], per_page: 10)
  end
end
