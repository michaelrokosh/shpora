class FavoritesController < ApplicationController
	def create
		current_user.favorites.create(user_id: params[:user_id], page_id: params[:page_id])
		render nothing: true
	end

	def index
		@user = User.find_by(username: params[:user_id])
	end

	def destroy
		@favorite = Favorite.find_by(page_id: params[:page_id])
    	@favorite.destroy
    	render nothing: true
	end
end
