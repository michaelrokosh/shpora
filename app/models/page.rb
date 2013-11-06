class Page < ActiveRecord::Base
  belongs_to :user
  validates :url, presence: true, uniqueness: { scope: :user, message: "У вас уже есть страница с данной ссылкой" }
  validates :title, presence: true
  validates :content, presence: true
  def to_param  # overridden
    url
  end
end
