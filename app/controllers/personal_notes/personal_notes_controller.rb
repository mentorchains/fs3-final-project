module PersonalNote
  class PersonalNoteController < ::ApplicationController
    requires_plugin PersonalNote

    before_action :ensure_logged_in

    def index
    end
  end
end
