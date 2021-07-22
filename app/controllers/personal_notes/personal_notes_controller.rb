module PersonalNotes
  class PersonalNotesController < ::ApplicationController
    requires_plugin PersonalNotes

    before_action :ensure_logged_in

    def index
    end
  end
end
