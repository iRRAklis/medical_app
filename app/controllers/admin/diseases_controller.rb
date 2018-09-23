class Admin::DiseasesController < Admin::BaseController
	before_action :set_disease, only: [:show, :edit, :update]

	def index
		@diseases = Disease.all
	end

	def show
	end

	def new
		@disease = Disease.new
	end

	def create
	  @disease = Disease.new(disease_params)
	 
	  if @disease.save
	  	redirect_to admin_diseases_path
	  else
	  	flash.now[:error] = @disease.errors.full_messages
			render 'new'
	  end
	end

	def edit
	end

	def update
		if @disease.update(disease_params)
			redirect_to admin_diseases_path
		else
			flash.now[:error] = @disease.errors.full_messages
			render 'edit'
		end
	end

	private
	  def disease_params
      params.require(:disease).permit(:name, :probability)
    end

    def set_disease
    	@disease = Disease.find(params[:id])
    end
end