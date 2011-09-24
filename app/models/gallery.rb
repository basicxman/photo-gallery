class Gallery < ActiveRecord::Base
  belongs_to :user
  has_many   :images, :dependent => :destroy
  accepts_nested_attributes_for :images, :reject_if => lambda { |f| f["image"].nil? }

  validates_presence_of :title
  validates_presence_of :description
  validates_length_of   :title, :minimum => 2, :maximum => 64

  scope :latest_first, order("updated_at DESC")

  def to_param
    "#{self.id}-#{self.title.parameterize}"
  end

  def thumbnail
    if self.images.length > 0
      self.images.first.image.url(:thumb)
    else
      PhotoGallery::Application.config.missing_image
    end
  end

  def self.get_default
    Gallery.latest_first.limit(1).first
  end
end
