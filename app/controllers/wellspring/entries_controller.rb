require_dependency "wellspring/application_controller"

module Wellspring
  class EntriesController < ApplicationController
    before_action :set_entry, only: [:show, :edit, :update, :destroy, :preview]

    def index
      Entry.clean_up_unsaved_entries!
      @entries = Entry.drafts_and_published.where(type: content_class)
    end

    def show
    end

    def new
      @entry = Entry.new(type: content_class, user: current_user)
      @entry.save!(validate: false)
      redirect_to edit_content_entry_path(@entry)
    end

    def edit
    end

    def create
      @entry = Entry.new(entry_params)

      if @entry.save
        redirect_to content_entry_path(@entry), notice: 'Entry was successfully created.'
      else
        render :new
      end
    end

    def update
      if @entry.update(entry_params)
        @entry.update_attribute(:status, :draft) if params[:draft].present? || params[:unpublish].present?
        @entry.update_attribute(:status, :published) if params[:publish].present?

        redirect_to content_entry_path(@entry), notice: 'Entry was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @entry.destroy
      redirect_to content_entries_path, notice: 'Entry was successfully destroyed.'
    end

    def preview
      @entry.body = params[:text]
      render layout: false
    end

    private

    def set_entry
      @entry = Entry.find_by_token!(params[:id])
    end

    def entry_params
      allowed_attrs = %i(id type title slug published_at body raw_tags author_name meta_description parent_id)
        .concat(content_class.constantize.content_attributes.keys)

      params.require(:entry).permit(*allowed_attrs)
    end

    def content_class
      @content_class ||= params[:content_class].classify
    end
    helper_method :content_class
  end
end
