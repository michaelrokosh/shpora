require 'open-uri'

class SetPageContent
  def self.call(page:, file_url:)
    new(page, file_url).perform
  end

  def initialize(page, file_url)
    @page = page
    @file_url = file_url
  end

  def perform
    page.update(content: file_content) if page
  end

  private

  attr_reader :page, :file_url

  def file_content
    file = open(file_url).read
    Yomu.read :html, file
  end
end
