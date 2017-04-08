class Page < ActiveRecord::Base
  acts_as_taggable

  has_many :favorites
  has_many :favoriters, through: :favorites
  belongs_to :user

  VALID_URL_REGEX = /\A[a-zA-Z0-9-]+\Z/
  validates :title, presence: true
  validate :validate_tag

  mount_uploader :content_key, FileUploader

  # after_create :set_content, unless: :content_key_blank?

  def validate_tag
    tag_list.each do |tag|
      errors.add(:tag, "должнен быть в пределе 3-15 символов") if tag.length > 15 || tag.length < 3
    end
  end

  def to_param
    url || id
  end

  def document_text
    yomu = Yomu.new content_key.url
    yomu.text
  end

  private

  def content_key_blank?
    content_key.blank?
  end

  def set_content
    update(content: document_text)
  end
end
