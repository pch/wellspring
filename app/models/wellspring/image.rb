module Wellspring
  class Image < ActiveRecord::Base
    mount_uploader :image, Wellspring::ImageUploader

    belongs_to :entry

    before_validation :set_token

    private

    def set_token
      self.token ||= (Time.now.to_f.round(3) * 1000).to_i
    end
  end
end
