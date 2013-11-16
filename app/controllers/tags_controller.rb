class TagsController < ApplicationController

	def index
		@tags = Page.tag_counts_on(:tags)
		@pages = Page.tagged_with(@tag)
	end

	def show
		@tag = ActsAsTaggableOn::Tag.find_by name: params[:id]
		@pages = Page.tagged_with(@tag).paginate(:order => "created_at DESC", :page => params[:page], :per_page => 10)
	end
end