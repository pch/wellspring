module Wellspring
  class ApplicationController < ActionController::Base
    before_action :authenticate_user

    protected

    def current_user
      unless defined?(@current_user)
        @current_user = instance_eval(&Wellspring.configuration.current_user_lookup)
      end
      @current_user
    end
    helper_method :current_user

    def authenticate_user
      return if current_user

      redirect_to instance_eval(&Wellspring.configuration.sign_in_url)
    end

    def content_entries_path
      entries_path(content_class: content_class.tableize)
    end
    helper_method :content_entries_path

    def content_entry_path(entry)
      entry_path(entry, content_class: content_class.tableize)
    end
    helper_method :content_entry_path

    def new_content_entry_path
      new_entry_path(content_class: content_class.tableize)
    end
    helper_method :new_content_entry_path

    def edit_content_entry_path(entry)
      edit_entry_path(entry, content_class: content_class.tableize)
    end
    helper_method :edit_content_entry_path
  end
end
