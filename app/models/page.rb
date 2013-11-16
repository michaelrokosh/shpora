class Page < ActiveRecord::Base
  has_many :favorites
  belongs_to :user
  has_many :favoriters, through: :favorites
  VALID_URL_REGEX = /\A[a-zA-Z0-9-]+\Z/
  validates :url, presence: true, 
  			uniqueness: { scope: :user, message: "У вас уже есть страница с данной ссылкой" },
  			format: { with: VALID_URL_REGEX }
  validates :title, presence: true
  validates :content, presence: true
  validates :tag_list, presence: true
  acts_as_taggable
  def to_param  # overridden
    url
  end
end
