module Wellspring
  class ImageUploader < ::CarrierWave::Uploader::Base
    include ::CarrierWave::MiniMagick

    storage :file
    # storage :fog

    # Override the directory where uploaded files will be stored.
    # This is a sensible default for uploaders that are meant to be mounted:
    def store_dir
      "images/#{model.id}"
    end

    process :store_dimensions

    def extension_whitelist
      %w(jpg jpeg gif png ico)
    end

    protected

    def store_dimensions
      if file && model
        model.width, model.height = ::MiniMagick::Image.open(file.file)[:dimensions]
      end
    end

    # strips EXIF and other metadata from files
    def strip
      manipulate! do |img|
        img.strip
        img = yield(img) if block_given?
        img
      end
    end
  end
end