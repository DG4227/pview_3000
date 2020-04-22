class PhotoLink < ApplicationRecord
  validates :filepath, presence: true

  scope :larger_than, -> (height, width) { where("columns >= ? AND rows >= ?", height, width) }
  scope :smaller_than, -> (height, width) { where("columns <= ? AND rows <= ?", height, width) }

  def relative_filepath
    "vendor/images/#{filepath}.png"
  end

  def grayscale_relative_filepath
    "vendor/images/grayscale/#{filepath}.png"
  end
end
