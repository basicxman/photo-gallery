class Image < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :user

  has_attached_file :image, :styles => { :thumb => "150x150#", :medium => "500x500#" }

  validates_attachment_presence :image, :if => :image_file_name_changed?
  validates_attachment_size :image, :less_than => 3.megabytes, :if => :image_file_name_changed?
  validates_presence_of :title
  validates_length_of   :title, :minimum => 2, :maximum => 128

  scope :latest_first, order("updated_at DESC")

  def to_param
    "#{self.id}-#{self.title.parameterize}"
  end
end
