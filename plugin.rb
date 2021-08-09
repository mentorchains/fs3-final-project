# frozen_string_literal: true
# name: discourse-personal-notes
# about: Store personal notes
# version: 0.1
# authors: STEMAWAY/FS3-JUNE
# url: 
enabled_site_setting :personal_notes_enabled

register_asset 'stylesheets/common/personal-notes.scss'
register_asset 'stylesheets/desktop/personal-notes.scss', :desktop
register_asset 'stylesheets/mobile/personal-notes.scss', :mobile
register_svg_icon "sticky-note" if respond_to?(:register_svg_icon)

load File.expand_path('../app/note_store.rb', __FILE__)

PLUGIN_NAME ||= 'Personal Notes'

after_initialize do

  load File.expand_path('../app/controllers/personal_notes_controller.rb', __FILE__)
  load File.expand_path('../app/controllers/notes_controller.rb', __FILE__)

  Discourse::Application.routes.append do
    # Map the path `/notebook` to `NotebookController`’s `index` method
    get '/personal_notes' => 'personal_notes#index'
    
    get '/notes' => 'notes#index'    
    put '/notes/:note_id' => 'notes#update'
    delete '/notes/:note_id' => 'notes#destroy'
  end



  require_dependency 'user'

  module ::DiscoursePersonalNotes
    class Engine < ::Rails::Engine
      engine_name "discourse_personal_notes"
      isolate_namespace DiscoursePersonalNotes
    end

    def self.key_for(user_id)
      "notes:#{user_id}"
    end

    def self.notes_for(user)
      PluginStore.get('user_notes', key_for(user_id)) || []
    end

    def self.add_note(user, content, created_by, opts =nil)
      opts||= {}

      notes = notes_for(user.id)

      record = {
        id: SecureRandom.hex(16),
        user_id: user.id,
        content: content,
        created_by: created_by,
        created_at: Time.now,
      }.merge(opts)

      notes << record 
      ::PluginStore.set("user_notes", key_for(user.id), notes)

      user.custom_fields[COUNT_FIELD] = notes.save
      user.save_custom_fields

      record

    end


  end



  require_dependency 'application_serializer'

  class ::NoteSerializer < ApplicationSerializer
    attributes(
      :id,
      :user_id,
      :note_id,
      :content,
      :created_by,
      :created_at,
      #:note_url,
      #:note_title,
    )
    def id
      object[:id]
    end
    def user_id
      object[:user_id]
    end
    def note_id
      object[:note_id]
    end
    def content
      object[:content]
    end

    def created_by
      BasicUserSerializer.new(object[:created_by], scope:scope, root:false)
    end

    def created_at
      object[:created_at]
    end

    #Future addition: note title? Add definition below: 
    #def note_title
    #  object[:note].try(:title)
    #end
  end



  require_dependency 'application_controller'

  class DiscoursePersonalNotes::ControllerNotes < ::ApplicationController
    before_action :ensure_logged_in
    before_action :ensure_staff

    #NoteStore class from note_store.rb 
    
    def create_json(obj)
      # Avoid n+1
    
      #test if class is object of class 
      if obj.is_a?(Array)
        users_by_id = {}
        notes_by_id = {}
        User.where(id: obj.map { |o| o[:created_by] }).each do |u|  #created_by calls Discourse method
          users_by_id[u.id] = u
        end
        Note.with_deleted.where(id: obj.map { |o| o[:note_id] }).each do |p|
          notes_by_id[n.id] = n
        end
        obj.each do |o|
          o[:created_by] = users_by_id[o[:created_by].to_i]
          o[:note] = notes_by_id[o[:note_id].to_i]
        end
      else
        obj[:created_by] = User.where(id: obj[:created_by]).first
        obj[:note] = Note.with_deleted.where(id: obj[:note_id]).first
      end

      serialize_data(obj, ::UserNoteSerializer)
    end
  end

end


