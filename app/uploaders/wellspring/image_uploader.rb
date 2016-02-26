module Wellspring
  class ImageUploader < ::CarrierWave::Uploader::Base
    include ::CarrierWave::MiniMagick

    def store_dir
      "images/#{model.entry.class.name.pluralize.underscore.gsub('_', '-')}/#{model.created_at.to_date.to_s}"
    end

    def filename
      if original_filename.present?
        "#{model.token}#{::File.extname(original_filename).downcase}"
      else
        super
      end
    end

    process :store_metadata
    process :fix_rotation

    def extension_whitelist
      %w(jpg jpeg gif png ico)
    end

    protected

    def store_metadata
      if file && model
        img = ::MiniMagick::Image.open(file.file)

        model.width, model.height = img[:dimensions]
        model.exif = img.exif

        model.content_type = file.content_type
        model.file_size    = file.size
      end
    end

    def fix_rotation
      manipulate! do |img|
        img = img.auto_orient
        img
      end
    end
  end
end