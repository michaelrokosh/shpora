class Page < ActiveRecord::Base
  acts_as_taggable

  has_many :favorites
  has_many :favoriters, through: :favorites
  belongs_to :user

  VALID_URL_REGEX = /\A[a-zA-Z0-9-]+\Z/
  validates :url, presence: true,
  			uniqueness: { scope: :user, message: "У вас уже есть страница с данной ссылкой" },
  			format: { with: VALID_URL_REGEX }
  validates :title, presence: true
  validate :validate_tag

  before_create :set_content

  def validate_tag
    tag_list.each do |tag|
      errors.add(:tag, "должнен быть в пределе 3-15 символов") if tag.length > 15 || tag.length < 3
    end
  end

  def to_param
    url
  end

  def content_public_url
    content_url = STORAGE.objects.detect{|object| object.key == self.content_key }.public_url
  end

  def render_content
    content || content_public_url
  end

  private

  def set_content
    # Rails.logger.debug w
  end
end
