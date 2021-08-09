
class NotesController < ApplicationController
  def index
      Rails.logger.info 'Called NotesController#index'
      notes = NoteStore.get_notes()
      render json: { notes: notes.values }
  end

  def update
    Rails.logger.info 'Called NotesController#update'

    note_id = params[:note_id]
    note = {
      'id' => note_id,
      'content' => params[:note][:content]
    }

    NoteStore.add_note(note_id, note)

    render json: { note: note }
  end
  def destroy
    Rails.logger.info 'Called NotesController#destroy'

    NoteStore.remove_note(params[:note_id])

    render json: success_json
  end
end


##require_relative 'ControllerNotes'
##require_relative 'NoteSerializer'
##require_relative 'DiscoursePersonalNotes'
##require_dependency 'application_controller'
#
#class DiscoursePersonalNotes::NotesController < ApplicationController
#  
#  #include ControllerNotes
#  #include NoteSerializer
#  #include DiscoursePersonalNotes
#  
#  #Comment: Check requirements for 'ensure_logged_in'
#  #before_action :ensure_logged_in
#  #before_action :ensure_staff
#
#  def index
#    #Comment: Displays the notes associated with the user?
#
#  #  user = User.where(id: params[:user_id]).first
#   # raise Discourse::NotFound if user.blank?
#
#    notes = :: NoteStore.notes_for(params[:user_id])
#    render json: {
#      extras: { username: user.username },
#    user_notes: create_json(notes.reverse)
#    }
#
#    Rails.logger.info 'Called NotesController#index'
#    notes = NoteStore.get_notes()
#    render json: { notes: notes.values }
#  end
#
#  def update
#    #Comment: does this also need code to verify the user the note belongs to? 
#
#    Rails.logger.info 'Called NotesController#update'
#
#    note_id = params[:note_id]
#    note = {
#      'id' => note_id,
#      'content' => params[:note][:content]
#    }
#
#    NoteStore.add_note(note_id, note)
#
#    render json: { note: note }
#  end
#
#  def destroy
#    #Comment: Below, can be used to verify user identity prior to deleting
#
#    user = User.where(id: params[:user_id]).first
#    raise Discourse::NotFound if user.blank?
#
#    raise Discourse::InvalidAccess.new unless guardian.can_delete_user_notes?
#
#    Rails.logger.info 'Called NotesController#destroy'
#
#    NoteStore.remove_note(params[:note_id])
#
#    render json: success_json
#  end
#end