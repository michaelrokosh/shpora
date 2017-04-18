class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save { self.email = email.downcase }

  has_many :favorites
  has_many :pages
  has_many :favorite_pages, through: :favorites, source: :page
  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9]+\Z/
  validates :username, presence: true,
                      format: { with: VALID_USERNAME_REGEX, message: "должно состоять только из символов и цифр" },
                      uniqueness: { case_sensitive: false, message: "занато" },
                      length: { minimum: 3, maximum: 15, message: "должно быть в пределе 3-15 символов" },
                      exclusion: { in: %w(pages page tags tag search results recent top subject subjects categories category books book user users sign_in sign_out registration pro about contact adv advertise store shop),
                      message: "занят" }
  def to_param
    username
  end
end
