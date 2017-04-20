class HomeController < ApplicationController
  helper_method :upload_form, :default_user

	def index
		@recent_pages = Page.order('created_at desc').limit(5).offset(0)
		@tags = Page.tag_counts_on(:tags)
		if user_signed_in?
			@recent_user_pages = current_user.pages.order('created_at desc').limit(4).offset(0)
		end
	end

  private

  def default_user
    current_user || User.find_by(username: 'anonymous') || User.last
  end

  def upload_form
    STORAGE.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
  end
end
