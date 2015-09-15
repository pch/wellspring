module Wellspring
  module Concerns
    module Searchable
      extend ActiveSupport::Concern

      included do
        has_many :search_data, class_name: 'Wellspring::EntrySearchData'

        after_save :update_search_index
      end

      module ClassMethods
        def searchable_attributes(*args)
          @searchable_attributes = args if args.any?
          @searchable_attributes ||= []
        end

        def search(query)
          select('DISTINCT ON (entry_id) entry_id, wellspring_entries.*').
            joins(:search_data).
            where("search_data @@ plainto_tsquery('english', :q)", q: query).
            order("entry_id, ts_rank(search_data, plainto_tsquery('%s')) desc" % send(:sanitize_sql, query))
        end
      end

      def search_attributes
        self.class.searchable_attributes.each_with_object({}) do |attr_name, search_data|
          search_data[attr_name] = send(attr_name)
        end
      end

      def update_search_index
        Wellspring::EntrySearchData.index_entry_data(id, search_attributes)
      end
    end
  end
end