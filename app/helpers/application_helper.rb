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

	def page_export(page)
		if page.file_url
			link_to '', page.file_url, target: '_blank', class: 'btn fa fa-download'
		else
			link_to 'Export Page', page_path(page, format: :docx)
		end
	end
end
