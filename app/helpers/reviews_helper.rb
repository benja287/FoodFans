module ReviewsHelper
  def review_form_path(lugar, comida)
    if comida
      lugare_comida_reviews_path(lugar, comida)  # Para una comida dentro de un lugar
    elsif lugar
      lugare_reviews_path(lugar)  # Para el lugar en sí
    else
      reviews_path  # Ruta genérica si no hay lugar ni comida
    end
  end
end
