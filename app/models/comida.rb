class Comida < ApplicationRecord
  belongs_to :lugar
  has_one_attached :photo
  has_many :opinions, dependent: :destroy

end
