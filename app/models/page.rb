class Page < ActiveRecord::Base
  acts_as_taggable
  mount_uploader :content_key, FileUploader

  has_many :favorites
  has_many :favoriters, through: :favorites
  belongs_to :user

  validates :title, presence: true
  validate :validate_tag

  before_save :set_url, unless: :url_blannk?

  # after_create :set_content, if: :content_key_blank?

  def validate_tag
    tag_list.each do |tag|
      errors.add(:tag, "должнен быть в пределе 3-15 символов") if tag.length > 15 || tag.length < 3
    end
  end

  def to_param
    url
  end

  def render_content
    content || document_text
  end

  def document_text
    yomu = Yomu.new content_key.url
    yomu.text
  end

  private

  def url_blannk?
    url.blank?
  end

  def set_url
    self.url = "#{title}-#{id}"
  end

  def content_key_blank?
    content_key.blank?
  end

  def set_content
    self.update(content: document_text) if document_text
  end
end
