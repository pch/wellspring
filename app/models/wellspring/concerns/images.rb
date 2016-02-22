module Wellspring
  module Concerns
    module Images
      extend ActiveSupport::Concern

      included do
        has_many :images, class_name: 'Wellspring::Image', foreign_key: :entry_id
        has_many :hero_images, -> { where(hero: true) }, class_name: 'Wellspring::Image', foreign_key: :entry_id
      end

      def hero_image
        @hero_image ||= hero_images.order('id desc').first
      end
    end
  end
end
