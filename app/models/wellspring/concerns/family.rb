module Wellspring
  module Concerns
    module Family
      extend ActiveSupport::Concern

      included do
        belongs_to :parent, class_name: 'Wellspring::Entry'
        has_many :children, class_name: 'Wellspring::Entry', foreign_key: :parent_id
      end

      module ClassMethods
        def parent_entry(parent_entry_klass = nil)
          if parent_entry_klass
            @parent_entry ||= parent_entry_klass.to_s.classify
            alias_method parent_entry_klass, :parent
          end
          @parent_entry
        end

        def child_entries(child_entry_klass)
          @child_entry ||= child_entry_klass.to_s.singularize.classify
          alias_method child_entry_klass, :children
        end
      end

      def can_have_parent?
        self.class.parent_entry.present?
      end

      def possible_parents
        Wellspring::Entry.where(type: self.class.parent_entry)
      end
    end
  end
end
