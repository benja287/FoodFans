class Comida < ApplicationRecord
  belongs_to :lugar
  has_one_attached :foto


end
