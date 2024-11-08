class ComidasController < ApplicationController
  before_action :authenticate_user!

  def index
    # Muestra todas las comidas del lugar
    @lugar = Lugar.find(params[:lugare_id])
    @comidas = @lugar.comidas
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
    if @comida.save
      # Redirige al perfil del lugar con un mensaje de éxito
      redirect_to lugare_path(@lugar), notice: "Comida registrada exitosamente."
    else
      render :new
    end
  end

  private

  # Define los parámetros permitidos para una comida
  def comida_params
  params.require(:comida).permit(:nombre, :sabor, :precio, :fecha_de_registro, :descripcion, :foto, tipo_comida: [])
end


end
