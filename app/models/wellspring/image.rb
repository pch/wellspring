module Wellspring
  class Image < ActiveRecord::Base
    mount_uploader :image, Wellspring::ImageUploader

    before_save :update_asset_attributes

    private

    def update_asset_attributes
      if image.present? && image_changed?
        self.content_type = image.file.content_type
        self.file_size    = image.file.size
      end
    end
  end
end