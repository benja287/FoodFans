
class Review < ApplicationRecord
  belongs_to :comida
  belongs_to :lugar
  belongs_to :user, optional: true # El usuario es opcional, no obligatorio
  
end
