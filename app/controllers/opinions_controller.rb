# app/controllers/opinions_controller.rb
class OpinionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reviewable, only: [:new, :create]

  def index
    @opinions = Opinion.all
  end

  def show
     @opinions = @reviewable.opinions
  end

  def new
   # Verifica que @reviewable esté siendo asignado correctamente
   if @reviewable.nil?
     redirect_to root_path, alert: 'No se especificó un recurso para la opinión.'
   end
   @opinion = @reviewable.opinions.build
 end

  def create
    @opinion = Opinion.new(opinion_params)
    @opinion.user = current_user
    @opinion.fecha = Date.today # Asigna la fecha actual

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
    if params[:lugare_id]
      @reviewable = Lugar.find(params[:lugare_id])
    elsif params[:comida_id]
      @reviewable = Comida.find(params[:comida_id])
    else
      @reviewable = nil
    end
  end

  def opinion_params
    params.require(:opinion).permit(:fecha, :puntaje, :comentario)
  end

  # Redirige después de la creación de la opinión
  def after_create_path
    if @reviewable.is_a?(Lugar)
      lugare_opinions_path(@reviewable)  # Redirige al lugar
    elsif @reviewable.is_a?(Comida)
      lugare_comida_opinions_path(@reviewable.lugar, @reviewable)  # Redirige a la comida dentro del lugar
    else
      opinions_index_path  # Redirige al índice de opiniones en caso de error
    end
  end
end
