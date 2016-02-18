module Wellspring
  module Concerns
    module Taggable
      extend ActiveSupport::Concern

      included do
        attr_accessor :raw_tags
        before_save :split_raw_tags
      end

      module ClassMethods
        def self.tagged_with(tag)
          where('tags @> ?', "{#{tag}}")
        end
      end

      private

      def split_raw_tags
        return if raw_tags.blank?

        self.tags = raw_tags.split(',').map { |t| t.strip }
      end
    end
  end
end
