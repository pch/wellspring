module Wellspring
  class Entry < ActiveRecord::Base
    include Wellspring::Concerns::Searchable
    include Wellspring::Concerns::Taggable
    include Wellspring::Concerns::Images
    include Wellspring::Concerns::Family

    enum status: [ :fresh, :draft, :published ]

    belongs_to :user

    scope :drafts, -> { where(status: :draft) }
    scope :published, -> { where(status: :published).where('published_at <= ?', Time.zone.now) }
    scope :drafts_and_published, -> { where(status: [:draft, :published]) }

    validates :title, presence: true
    validates :slug, uniqueness: { scope: :type, allow_blank: true }

    before_create :set_token
    before_save :set_slug

    def self.content_attr(attr_name, attr_type = :string)
      content_attributes[attr_name] = attr_type

      define_method(attr_name) do
        self.payload ||= {}
        self.payload[attr_name.to_s]
      end

      define_method("#{attr_name}=".to_sym) do |value|
        self.payload ||= {}
        self.payload[attr_name.to_s] = value
      end
    end

    def self.content_attributes
      @content_attributes ||= {}
    end

    def self.clean_up_unsaved_entries!
      where(status: :fresh).where('created_at < ?', 2.days.ago).destroy_all
    end

    private

    def set_token
      self.token ||= SecureRandom.base58(6)
    end

    def set_slug
      self.slug = title.parameterize if slug.blank? && title.present?
    end
  end
end
