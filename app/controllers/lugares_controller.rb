class LugaresController < ApplicationController
  before_action :authenticate_user!

  def new
    @lugar = Lugar.new
  end

  def create
    @lugar = Lugar.new(lugar_params)
    @lugar.user = current_user
    @lugar.fecha_de_registro=Date.today
    if @lugar.save
      # Redirige a la lista de lugares (lugares_path) después de un registro exitoso
      redirect_to lugares_path, notice: "Lugar registrado exitosamente."
    else
      render :new
    end
  end
  def index
    @lugares = Lugar.all

    # Filtrar los lugares por nombre y/o dirección
    if params[:search].present? && params[:direccion].present?
      # Si ambos parámetros están presentes, buscar por ambos
      @lugares = @lugares.where("nombre LIKE ? AND direccion LIKE ?", "%#{params[:search]}%", "%#{params[:direccion]}%")
    elsif params[:search].present?
      # Si solo hay un término de búsqueda por nombre
      @lugares = @lugares.where("nombre LIKE ?", "%#{params[:search]}%")
    elsif params[:direccion].present?
      # Si solo hay un término de búsqueda por dirección
      @lugares = @lugares.where("direccion LIKE ?", "%#{params[:direccion]}%")
    end
  end
  def show
    @lugar = Lugar.find(params[:id])
  end

  private

  def lugar_params
    params.require(:lugar).permit(:nombre, :direccion, :tipo, :puntaje, :descripcion, :fecha_de_registro)
  end
end
