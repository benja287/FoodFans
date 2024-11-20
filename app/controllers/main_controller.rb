class MainController < ApplicationController
  def home
    @lugares = Lugar.includes(:comidas).where.not(comidas: { id: nil })  # Obtener todos los lugares con comidas
  end
  def cargar_informacion
    # Aquí no necesitas hacer nada específico, solo redirigir a la vista de cargar información
  end
end
