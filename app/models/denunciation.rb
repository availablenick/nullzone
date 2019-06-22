class Denunciation < ApplicationRecord
  validates :denunciador, :denunciado, :tipo, :source_id, presence: true
end
