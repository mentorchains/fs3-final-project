module PersonalNotes
  class ActionsController < ::ApplicationController
    requires_plugin PersonalNotes

    before_action :ensure_logged_in

    #Below: rendering notes on load?
    #def index
    #  Rails.logger.info 'Called NotesController#index'
    #  notes = NoteStore.get_notes()
  
    #  render json: { notes: notes.values }
    #end

    def index
      render_json_dump({ actions: [] })
    end

    def update 
      Rails.logger.info 'Called NotesController#update'

      note_id = params[:note_id]
      note = {
        'id' => note_id,
        'content' => params[:note][:content]
      } 
      #Content refers to what's written in the text box, what is 'note'?
      #Is that the object?

      NoteStore.add_note(note_id, note)

      render json: { note: note }
    end

    #should also have a way to delete?

    #Does this show a list of notes?
    def show
      render_json_dump({ action: { id: params[:id] } })
    end
  end
end
