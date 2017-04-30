class Admin::PagesController < Admin::BaseController
  before_action :find_page, only: [:show, :edit, :update, :destroy]

  def index
    @q = Page.ransack(params[:q])
    @pages =@q.result.paginate(page: params[:page], per_page: 40)
  end

  def show

  end

  def edit
  end

  def update
    @page.update(page_params)
    redirect_to admin_pages_path
  end

  def destroy
    @page.destroy
    redirect_to admin_pages_path
  end

  private

  def find_page
    @page = Page.find_by(url: params[:id])
  end

  def page_params
    params.require(:page)
          .permit!
  end
end
