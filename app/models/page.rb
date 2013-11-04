class Page < ActiveRecord::Base
  belongs_to :user
  validates :url, presence: true, uniqueness: true
  validates :title, presence: true
  validates :content, presence: true
  def to_param  # overridden
    url
  end
end
