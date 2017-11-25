# require 'pdfkit'

class PagesController < ApplicationController
  layout :resolve_layout

  def index
    @q = Page.ransack(params[:q])
    @pages = @q.result.order('created_at DESC').paginate(page: params[:page], per_page: 10)
  end

  def show
    @page = Page.find_by(url: params[:id])
    @user = @page&.user
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)
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

  # def page_pdf
  #   PagePdf.new(@page)
  # end
  #
  # def send_to_pdf
  #   send_file page_pdf.to_pdf,
  #     filename: page_pdf.filename,
  #     type: "application/pdf",
  #     disposition: "attachment"
  # end

  def page_params
    params.require(:page)
          .permit(:content, :title, :url, :tag_list, :file_url)
          .merge(user_id: current_user.id, source: 2)
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
