
class Review < ApplicationRecord
    belongs_to :user
    belongs_to :lugar, optional: true
    belongs_to :comida, optional: true
    validate :must_have_lugar_or_comida

  private

  def must_have_lugar_or_comida
    unless lugar.present? ^ comida.present? # XOR operator - debe tener uno u otro, pero no ambos
      errors.add(:base, "Debe estar asociado a un lugar o una comida, pero no a ambos")
    end
  end
end
