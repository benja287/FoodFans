class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reviewable, only: [:new, :create]

  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @lugar = Lugar.find(params[:lugare_id]) if params[:lugare_id]
    @comida = Comida.find(params[:comida_id]) if params[:comida_id]
    # Asocia la review con el lugar o la comida según corresponda
    if @lugar
      @review.lugar = @lugar
    elsif @comida
      @review.comida = @comida
    end

    if @review.save
      redirect_to reviews_index_path, notice: 'Review creada exitosamente.'
    else
      flash.now[:alert] = 'Error al crear la review. Por favor, revisa los campos.'
      render :new
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  private

  def set_reviewable
    @lugar = Lugar.find(params[:lugare_id]) if params[:lugare_id]
    @comida = Comida.find(params[:comida_id]) if params[:comida_id]
  end

  def review_params
    params.require(:review).permit(:fecha, :puntaje, :opinion)
  end
end
