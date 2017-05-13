class EarnsController < ApplicationController
  def index
    @upload_files = current_user.pages.where(source: 1)
  end
end
