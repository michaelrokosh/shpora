module ApplicationHelper
	def on_the_edit_page?
		controller_name == 'pages' && action_name == 'new' || action_name == 'edit'
	end

	def show_page_content(content)
		if content.blank?
			render 'content_processing'
		else
			sanitize content
		end
	end
end
