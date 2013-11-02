class PagesController < ApplicationController
  def new
    @page = Page.new
    @user = User.find_by username: params[:id]
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      redirect_to @page
    else
      render 'new'
    end
  end

  def show
    @page = Page.find_by url: (params[:id])
  end

  private

    def page_params
      params.require(:page).permit(:title, :content, :url)
    end
end
