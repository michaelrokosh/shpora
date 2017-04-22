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
			link_to I18n.t('labels.download'), page.file_url, target: '_blank', class: 'btn btn-md btn-default fa fa-download'
		else
			link_to I18n.t('labels.download'), download_user_page_path(page.user.username, page.url, format: :docx), class: 'btn btn-md btn-default fa fa-download'
		end
	end
end
