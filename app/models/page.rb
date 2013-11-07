class Page < ActiveRecord::Base
  belongs_to :user
  VALID_URL_REGEX = /\A[a-zA-Z0-9-]+\Z/
  validates :url, presence: true, 
  			uniqueness: { scope: :user, message: "У вас уже есть страница с данной ссылкой" },
  			format: { with: VALID_URL_REGEX }
  validates :title, presence: true
  validates :content, presence: true
  def to_param  # overridden
    url
  end
end
