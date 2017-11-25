class UploadsController < ApplicationController
  def create
    Page.create(page_params)
    render nothing: true
  end

  private

  def page_params
    params.require(:page)
          .permit(:file_url, :title)
          .merge( user_id: default_user.id,
                  amount: rand_amount,
                  source: 1)
  end

  def default_user
    current_user || User.find_by(username: 'anonymous') || User.last
  end

  def rand_amount
    rand(0.01..0.11).round(2)
  end
end
