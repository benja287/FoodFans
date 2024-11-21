class Opinion < ApplicationRecord
  belongs_to :user
  belongs_to :lugar, optional: true
  belongs_to :comida, optional: true

end
