class Page < ActiveRecord::Base
  belongs_to :user

  def to_param  # overridden
    url
  end
end
