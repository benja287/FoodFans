class OpinionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_reviewable, only: [:index, :new, :create]
  
    def index
      if params[:lugare_id] && params[:comida_id]
        @lugar = Lugar.find(params[:lugare_id])
        @comida = @lugar.comidas.find(params[:comida_id])
        @opinions = @comida.opinions
      elsif params[:lugare_id]
        @lugar = Lugar.find(params[:lugare_id])
        @opinions = @lugar.opinions
      else
        @opinions = Opinion.all
      end
    end
  
    def new
      @opinion = @reviewable.opinions.build
    end
  
    def create
      @opinion = @reviewable.opinions.build(opinion_params)
      @opinion.user = current_user
      @opinion.fecha = Date.today
  
      # Asignar lugar_id y comida_id según el tipo de recurso
      if @reviewable.is_a?(Comida)
        @opinion.lugar_id = @reviewable.lugar.id  # Asignar el lugar de la comida
        @opinion.comida_id = @reviewable.id      # Asignar el id de la comida
      elsif @reviewable.is_a?(Lugar)
        @opinion.lugar_id = @reviewable.id       # Solo asignar el lugar
      end
  
      if @opinion.save
        redirect_to after_create_path, notice: 'Opinión creada exitosamente.'
      else
        render :new
      end
    end
  
    private
  
    def set_reviewable
      @reviewable = if params[:lugare_id] && !params[:comida_id]
                      Lugar.find(params[:lugare_id])
                    elsif params[:lugare_id] && params[:comida_id]
                      Lugar.find(params[:lugare_id]).comidas.find(params[:comida_id])
                    end
  
      unless @reviewable
        redirect_to root_path, alert: 'No se encontró el recurso para la opinión.'
      end
    end
  
    def opinion_params
      params.require(:opinion).permit(:puntaje, :comentario)
    end
  
    def after_create_path
    case @reviewable
    when Lugar
      lugare_opinions_path(@reviewable) # Redirigir a las opiniones del lugar
    when Comida
      lugare_comida_opinions_path(@reviewable.lugar, @reviewable) # Redirigir a las opiniones de la comida
    end
  end
  end