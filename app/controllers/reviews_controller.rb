class ReviewsController < ApplicationController
  before_action :authenticate_user! # Asegúrate de que el usuario esté logueado

  def index
    @reviews = Review.all
  end

  def new
    @lugar = Lugar.find(params[:lugare_id])
    @comida = Comida.find(params[:comida_id]) if params[:comida_id]
    @review = Review.new
  end

  def create
  @lugar = Lugar.find(params[:lugare_id])
  @comida = Comida.find(params[:comida_id]) if params[:comida_id]
  @review = @lugar.reviews.new(review_params)

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

  def review_params
    params.require(:review).permit(:fecha, :puntaje, :opinion)
  end
end
