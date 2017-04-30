require "render_anywhere"

class PagePdf
  include RenderAnywhere

  def initialize(page)
    @page = page
  end

  def to_pdf
    kit = PDFKit.new(page.content, page_size: 'Legal')
    kit.to_file("#{page.title.first(10)}.pdf")
  end

  def filename
    "#{page.title.first(10)}.pdf"
  end

  private

  attr_reader :page
end
