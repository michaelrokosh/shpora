class PagesController < ApplicationController
  def new
    @page = Page.new
    @user = User.find_by_username(params[:id])
  end

  def show
    @page = Page.find_by_url(params[:id])
  end

  def create
    @page = Page.new(page_params)
    @user = User.find_by_username(params[:id])
    if @page.save
      redirect_to @page
    else
      render 'new'
    end
  end

  def edit
    @page = Page.find_by_url(params[:id])
  end

  def destroy
    @page = Page.find_by_url(params[:id])
    @page.destroy
    redirect_to user_path(current_user)
  end

  private
    def page_params
      params.require(:page).permit(:user_id, :title, :content, :url)
    end
end
