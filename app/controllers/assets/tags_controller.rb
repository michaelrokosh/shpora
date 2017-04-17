class Assets::TagsController < ApplicationController
  def index
    tags = Tag.pluck(:name)
    render json: tags
  end
end
