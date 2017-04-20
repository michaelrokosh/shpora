class Authentication < ActiveRecord::Base
  belongs_to :user
  validates :provider, :uid, presence: true

  def update_omniauth!(auth)
    self.update_attributes(token:auth.credentials.token,
                           token_expires_at: Time.at(auth.credentials.expires_at || 60.days.from_now.to_i))
  end

  def provider_name
    if provider == 'google_oauth2'
      'Google'
    else
      provider
    end
  end

  def is_valid?
    token_expires_at && token_expires_at > DateTime.now
  end

  def unauthorize!
    self.update_attributes(token: nil, token_expires_at: nil)
  end
end
