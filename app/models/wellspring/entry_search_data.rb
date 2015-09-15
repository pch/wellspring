module Wellspring
  class EntrySearchData < ActiveRecord::Base
    belongs_to :entry

    validates :entry_id, presence: true
    validates :attr_name, presence: true, uniqueness: { scope: :entry_id }

    def self.index_entry_data(entry_id, search_attributes)
      search_attributes.each do |attr_name, value|
        find_or_create_by(entry_id: entry_id, attr_name: attr_name)

        where(entry_id: entry_id, attr_name: attr_name).update_all([
          "raw_data = :search_data, search_data = to_tsvector('english', :search_data)",
          search_data: value
        ])
      end
    end
  end
end
