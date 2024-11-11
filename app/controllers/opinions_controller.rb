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

    if params[:lugar_id]
      @opinion.lugar = @lugar
    elsif params[:comida_id]
      @opinion.comida = @comida
    end

    if @opinion.save
      redirect_to after_create_path, notice: 'Opinión creada exitosamente.'
    else
      render :new
    end
  end

  private

  def set_reviewable
    @lugar = Lugar.find(params[:lugar_id]) if params[:lugar_id]
    @comida = Comida.find(params[:comida_id]) if params[:comida_id]
  end

  def opinion_params
    params.require(:opinion).permit(:fecha, :puntaje, :comentario)
  end

  def after_create_path
    if @opinion.lugar
      lugare_path(@opinion.lugar)
    elsif @opinion.comida
      lugare_comida_path(@opinion.comida.lugar, @opinion.comida)
    else
      opinions_index_path
    end
  end
end
