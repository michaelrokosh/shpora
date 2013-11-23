class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #before_save { self.username = username.downcase }
  before_save { self.email = email.downcase }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :favorites
  has_many :pages
  has_many :favorite_pages, through: :favorites, source: :page
  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9]+\Z/
  validates :username, presence: true, 
                      format: { with: VALID_USERNAME_REGEX, message: "должнен состоять только из символов и цифр" },
                      uniqueness: { case_sensitive: false, message: "занат" },
                      length: { minimum: 3, maximum: 15, message: "должнен быть в пределе 3-15 символов" },
                      exclusion: { in: %w(pages page tags tag search results recent top subject subjects categories category books book user users sign_in sign_out registration pro about contact adv advertise store shop),
                      message: "занят" }
  def to_param
    username
  end
  
end
