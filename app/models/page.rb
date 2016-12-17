class Page < ActiveRecord::Base
  acts_as_taggable
  has_many :favorites
  belongs_to :user
  has_many :favoriters, through: :favorites
  VALID_URL_REGEX = /\A[a-zA-Z0-9-]+\Z/
  validates :url, presence: true,
  			uniqueness: { scope: :user, message: "У вас уже есть страница с данной ссылкой" },
  			format: { with: VALID_URL_REGEX }
  validates :title, presence: true
  validates :content, presence: true
  #validates :tag, length: { minimum: 3, maximum: 15, message: "должнен быть в пределе 3-15 символов" }
  validate :validate_tag

  def validate_tag
    tag_list.each do |tag|
      # This will only accept two character alphanumeric entry such as A1, B2, C3. The alpha character has to precede the numeric.
      errors.add(:tag, "должнен быть в пределе 3-15 символов") if tag.length > 15 || tag.length < 3
    end
  end

  def to_param  # overridden
    url
  end
end
