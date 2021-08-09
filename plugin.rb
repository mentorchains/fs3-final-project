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
    PluginStore.get('user_notes', key_for(user_id) || []
  end

  def self.add_note(user, raw, created_by, opts =nil)
    opts||= {}

    notes = notes_for(user.id)

    record = {
      id: SecureRandom.hex(16),
      user_id: user.id,
      raw: raw;
      created_by: created_by,
      created_at: Time.now
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
    :post_id,
    :content
    #:post_title
  )
  def id
    object[:id]
  end
  def user_id
    object[:user_id]
  end
  def post_id
    object[:post_id]
  end
  def content
    object[:content]
  end
  #Future addition: note title? Add definition below: 
  #def post_title
  #  object[:post].try(:title)
  #end
end



require_dependency 'application_controller'

class DiscoursePersonalNotes::notes_controller < ::ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_staff

  #stuff from note_store.rb 