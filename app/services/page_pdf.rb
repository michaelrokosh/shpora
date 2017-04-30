require "render_anywhere"

class PagePdf
  include RenderAnywhere

  def initialize(page)
    @page = page
  end

  def to_pdf
    kit = PDFKit.new(<<-HTML)
      page.content
    HTML
    kit.to_file("#{page.title}.pdf")
  end

  def filename
    "#{page.title}.pdf"
  end

  private

  attr_reader :page
end
