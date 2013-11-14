class FavoritesController < ApplicationController
	def create
		current_user.favorites.create(user_id: params[:user_id], page_id: params[:page_id])
		render :layout => false
	end
end
