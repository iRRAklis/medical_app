class ArticlesController < ApplicationController
	before_action :authorize_user
	
	def index
		@articles = Article.all
	end

	def show
		@article = Article.find(params[:id])
	end

	private
		def authorize_user
      if current_user.blank?
        flash[:error] = "You must sign in first."
        redirect_to root_path
      end
    end
end