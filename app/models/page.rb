class Page < ActiveRecord::Base
  acts_as_taggable

  has_many :favorites
  has_many :favoriters, through: :favorites
  belongs_to :user

  validates :title, presence: true
  validate :validate_tag

  before_save :set_url, if: :url_blannk?

  after_create :set_content, unless: :file_url_blank?

  def validate_tag
    tag_list.each do |tag|
      errors.add(:tag, "должнен быть в пределе 3-15 символов") if tag.length > 15 || tag.length < 3
    end
  end

  def to_param
    url
  end

  def document_text
    yomu = Yomu.new file_url
    yomu.text
  end

  private

  def url_blannk?
    url.blank?
  end

  def set_url
    self.url = "#{title}"
  end

  def file_url_blank?
    file_url.blank?
  end

  def set_content
    self.update(content: document_text) if document_text
  end
end
