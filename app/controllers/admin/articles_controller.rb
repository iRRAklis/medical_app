class Admin::ArticlesController < Admin::BaseController
	before_action :set_article, only: [:show, :edit, :update, :destroy]

	def index
		@articles = Article.all
	end

	def show
	end

	def new
		@article = Article.new
	end

	def create
	  @article = Article.new(article_params)
	 
	  if @article.save
	  	@article.diseases = diseases
	  	redirect_to admin_articles_path
	  else
	  	flash.now[:error] = @article.errors.full_messages
	  	render 'new'
	  end
	end

	def edit
	end

	def update
		if @article.update(article_params)
			@article.remove_image! if params[:remove_image] == "1"
			@article.diseases = diseases
			redirect_to admin_articles_path
		else
			flash.now[:error] = @article.errors.full_messages
			render 'edit'
		end
	end

	def destroy
		@article.destroy
		flash[:success] = "Article successfully deleted."

		redirect_to admin_articles_path
	end

	private
    def article_params
      params.require(:article).permit(:title, :body, :image, :remove_image)
    end

    def set_article
    	@article = Article.find(params[:id])
    end

    def diseases
      Disease.where(id: params[:disease_ids])
    end
end