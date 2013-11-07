class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :pages
  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9]+\Z/
  validates :username, presence: true, 
                      format: { with: VALID_USERNAME_REGEX },
                      uniqueness: { case_sensitive: false }
  def to_param
    username
  end
  
end
