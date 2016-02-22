module Wellspring
  class Image < ActiveRecord::Base
    mount_uploader :image, Wellspring::ImageUploader

    belongs_to :entry

    before_validation :set_token

    private

    def set_token
      self.token ||= SecureRandom.hex(5)
    end
  end
end
