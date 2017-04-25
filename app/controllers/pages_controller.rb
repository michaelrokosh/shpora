class PagesController < ApplicationController
  layout :resolve_layout
  def new
    @page = Page.new
    @user = User.find_by(username: params[:id])
  end

  def index
    @pages = Page.order('created_at DESC').paginate(page: params[:page], per_page: 10)
  end

  def show
    @page = Page.find_by(url: params[:id])
    @user = User.find_by(username: params[:user_id])
  end

  def download
    user = User.find_by(username: params[:user_id])
    @page = Page.find_by(url: params[:id], user_id: user.id)
    respond_to do |format|
      format.docx{
        file = Htmltoword::Document.create @page.content
        send_data file, disposition: 'attachment', filename: "#{@page.title}.docx"
      }
    end
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
    params.require(:page)
          .permit(:content, :title, :url, :tag_list, :file_url)
          .merge(user_id: current_user.id)
  end

  def resolve_layout
    case action_name
    when "show"
      "shpora"
    else
      "application"
    end
  end
end
