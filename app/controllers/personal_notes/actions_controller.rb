module PersonalNotes
  class ActionsController < ::ApplicationController
    requires_plugin PersonalNotes

    before_action :ensure_logged_in

    def index
      Rails.logger.info 'Called NotesController#index'
      notes = NoteStore.get_notes()
  
      render json: { notes: notes.values }
    end

    #BELOW: 
    #This is the original actions_controller I found from frontend
    #def index
    #  render_json_dump({ actions: [] })
    #end


    #Does this show a list of notes?
    def show
      render_json_dump({ action: { id: params[:id] } })
    end
  end
end
