class HomeController < ApplicationController
	
	def index
		@recent_pages = Page.order("created_at desc").limit(5).offset(0)
		@tags = Page.tag_counts_on(:tags)
		if user_signed_in?
			@recent_user_pages = current_user.pages.order("created_at desc").limit(4).offset(0)
		end
	end
end
