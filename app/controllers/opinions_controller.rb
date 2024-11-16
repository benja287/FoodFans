# app/controllers/opinions_controller.rb
class OpinionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reviewable, only: [:new, :create]

  def index
    @opinions = Opinion.all
  end

  def show
    @opinion = Opinion.find(params[:id])
  end

  def new
    @opinion = Opinion.new
  end

  def create
    @opinion = Opinion.new(opinion_params)
    @opinion.user = current_user

    # Asocia la opinión al @reviewable (lugar o comida)
    if @reviewable.is_a?(Lugar)
      @opinion.lugar = @reviewable
    elsif @reviewable.is_a?(Comida)
      @opinion.comida = @reviewable
    end

    if @opinion.save
      redirect_to after_create_path, notice: 'Opinión creada exitosamente.'
    else
      render :new
    end
  end

  private

  # Establece el objeto revisado (lugar o comida)
  def set_reviewable
    if params[:lugar_id]
      @reviewable = Lugar.find(params[:lugar_id])
    elsif params[:comida_id]
      @reviewable = Comida.find(params[:comida_id])
    end
  end

  def opinion_params
    params.require(:opinion).permit(:fecha, :puntaje, :comentario)
  end

  # Redirige después de la creación de la opinión
  def after_create_path
    if @reviewable.is_a?(Lugar)
      lugar_path(@reviewable)  # Redirige al lugar
    elsif @reviewable.is_a?(Comida)
      lugar_comida_path(@reviewable.lugar, @reviewable)  # Redirige a la comida dentro del lugar
    else
      opinions_index_path  # Redirige al índice de opiniones en caso de error
    end
  end
end
