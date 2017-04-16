class UploadsController < ApplicationController
  def create
    Page.create(page_params)
    render nothing: true
  end

  private

  def page_params
    params.require(:page)
          .permit(:file_url, :title)
          .merge(user_id: current_user.id)
  end
end
