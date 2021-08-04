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