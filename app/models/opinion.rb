class Opinion < ApplicationRecord
  belongs_to :user
  belongs_to :lugar, optional: true
  belongs_to :comida, optional: true
  validate :must_have_lugar_or_comida

  private

  def must_have_lugar_or_comida
    if lugar.blank? && comida.blank?
      errors.add(:base, "Debe estar asociado a un lugar o una comida")
    elsif lugar.present? && comida.present?
      errors.add(:base, "No puede estar asociado a un lugar y una comida simultáneamente")
    end
  end
end
