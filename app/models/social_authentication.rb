module SocialAuthentication

  def apply_omniauth(auth)
    self.email = auth.info.email if email.blank?
    authentications.create(provider: auth.provider, uid: auth.uid,
                           token: auth.credentials.token,
                           token_expires_at: Time.at(auth.credentials.expires_at || 60.days.from_now.to_i))
  end

  def facebook_auth
    authentications.find_by(provider: 'facebook')
  end

  def google_auth
    authentications.find_by(provider: 'google_oauth2')
  end


  def has_valid_google_auth?
    self.google_auth.present? && self.google_auth.token_expires_at? && self.google_auth.token_expires_at > Time.now
  end

  def has_valid_facebook_auth?
    self.facebook_auth.present? && self.facebook_auth.token_expires_at? && self.facebook_auth.token_expires_at > Time.now
  end

  def facebook
    token = authentications.find_by_provider(:facebook).token
    @facebook ||= Koala::Facebook::API.new(facebook_auth.token)
    block_given? ? yield(@facebook) : @facebook
    rescue Koala::Facebook::APIError => e
      logger.info e.to_s
      nil
  end

  def friends_list
    facebook.fql_query("select uid, name, pic_square from user where uid in (select uid2 from friend where uid1 = me())")
  end

  def friends_on_helpified
    uids = facebook.fql_query("SELECT uid FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = #{self.facebook_auth.uid}) AND is_app_user = 1")
    user_ids = Authentication.where("uid IN ('#{uids.map(&:values).flatten.join(',')}')").pluck(:user_id)
    users = User.basic_info.where("id IN ('#{user_ids.flatten.join(',')}')") if user_ids.any?
  end

  def assign_facebook_fields(auth)
    self.social_url = auth.extra.raw_info.link
  end

  def assign_google_oauth2_fields(auth)
    self.social_url = auth.extra.raw_info.link
  end

  def self.included(user)
    user.extend ClassMethods
  end

  module ClassMethods

    def find_for_oauth(auth, invite_token, signed_in_resource=nil)
      user = User.find_by(email: auth.info.email)
      unless user
        user = User.new(first_name: auth.info.first_name, last_name: auth.info.last_name,
                        email: auth.info.email,
                        username: auth.info.nickname.try(:parameterize),
                        password: Devise.friendly_token[0,20])
        user.send('assign_' + auth.provider + '_fields', auth)
        user.invite_token = invite_token || nil
        user.save
        user.create_account
      end
      user
    end
  end
end
