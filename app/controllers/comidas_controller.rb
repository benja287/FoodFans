class ComidasController < ApplicationController
  before_action :authenticate_user!

  def index
    # Muestra todas las comidas del lugar
    @lugar = Lugar.find(params[:lugare_id])
    @comidas = @lugar.comidas
    if params[:search].present?
      @comidas = @comidas.where("nombre LIKE ?", "%#{params[:search]}%")
    end

    if params[:tipo_comida].present?
      @comidas = @comidas.where("tipo_comida LIKE ?", "%#{params[:tipo_comida]}%")
    end
  end

  def show
    # Muestra una comida específica del lugar
    @lugar = Lugar.find(params[:lugare_id])
    @comida = @lugar.comidas.find(params[:id])
  end

  def new
    # Inicializa una nueva comida para el lugar específico
    @lugar = Lugar.find(params[:lugare_id])
    @comida = @lugar.comidas.new
  end

  def create
    # Crea una nueva comida asociada al lugar específico
    @lugar = Lugar.find(params[:lugare_id])
    @comida = @lugar.comidas.new(comida_params)
    @comida.fecha_de_registro =Date.today
    if @comida.save
      # Redirige al perfil del lugar con un mensaje de éxito
      redirect_to lugare_path(@lugar), notice: "Comida registrada exitosamente."
    else
      render :new
    end
  end
  def edit
    # Inicializa la comida que se va a editar
    @lugar = Lugar.find(params[:lugare_id])
    @comida = @lugar.comidas.find(params[:id])
  end

  def update
    # Actualiza una comida asociada al lugar específico
    @lugar = Lugar.find(params[:lugare_id])
    @comida = @lugar.comidas.find(params[:id])
    if @comida.update(comida_params)
      # Redirige al perfil del lugar con un mensaje de éxito
      redirect_to lugare_comida_path(@lugar, @comida), notice: "Comida actualizada exitosamente."
    else
      render :edit
    end
  end

  def destroy
    # Elimina una comida asociada al lugar específico
    @lugar = Lugar.find(params[:lugare_id])
    @comida = @lugar.comidas.find(params[:id])
    @comida.destroy
    redirect_to lugare_comidas_path(@lugar), notice: "Comida eliminada exitosamente."
  end

  private

  # Define los parámetros permitidos para una comida
  def comida_params
  params.require(:comida).permit(:nombre, :sabor, :precio, :fecha_de_registro, :descripcion, :photo, tipo_comida: [])
end


end
