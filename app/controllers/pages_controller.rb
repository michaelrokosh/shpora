class PagesController < ApplicationController
  def new
    @page = Page.new
    @user = User.find_by(username: params[:id])
  end

  def index
    @pages = Page.order('created_at DESC').paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find_by(username: params[:user_id])
    @page = @user.pages.find_by(url: params[:id])
  end

  def create
    @page = Page.new(page_params)
    @user = User.find_by(username: params[:id])
    if @page.save
      redirect_to user_page_path(current_user, @page)
    else
      render 'new'
    end
  end

  def update
    @page = Page.find_by(url: params[:id])
    if @page.update(page_params)
      redirect_to user_page_path(current_user, @page)
    else
      render 'edit'
    end
  end

  def edit
    @page = Page.find_by(url: params[:id])
  end

  def destroy
    @page = Page.find_by(url: params[:id])
    @page.destroy
    redirect_to user_path(current_user)
  end

  private

  def page_params
    params.require(:page).permit(:user_id, :title, :content, :url, :tag_list)
  end
end
