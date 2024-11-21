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

    if params[:search].present?
      @lugares = @lugares.where("nombre LIKE ?", "%#{params[:search]}%")
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
