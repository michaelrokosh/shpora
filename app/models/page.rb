class Page < ActiveRecord::Base
  acts_as_taggable

  enum source: { uploader: 1, form: 2 }

  has_many :favorites
  has_many :favoriters, through: :favorites
  belongs_to :user

  validates :title, presence: true
  validate :validate_tag
  validate :file_uniqueness

  after_save :set_url, if: :url_blannk?

  after_create :set_content, unless: :file_url_blank?
  after_create :update_total_amount, unless: :amount_nil?

  default_scope { order(created_at: :desc) }

  def validate_tag
    tag_list.each do |tag|
      errors.add(:tag, "должнен быть в пределе 3-15 символов") if tag.length > 15 || tag.length < 3
    end
  end

  def to_param
    url
  end

  private

  def amount_nil?
    amount.nil?
  end

  def update_total_amount
    total_amount = user.total_amount.to_i + amount
    user.update(total_amount: total_amount)
  end

  def url_blannk?
    url.blank?
  end

  def set_url
    self.update(url: "#{title}-#{id}")
  end

  def file_url_blank?
    file_url.blank?
  end

  def set_content
    SetPageContent.delay.call(page: self, file_url: file_url)
  end

  def file_uniqueness
    if Page.exists?(title: title, filesize: filesize)
      errors.add(:file, " #{title} already exists!")
    end
  end
end
