# name: notebook
# version: 0.7.0

register_svg_icon "sticky-note" if respond_to?(:register_svg_icon)
register_asset 'stylesheets/common/personal-notes.scss'
register_asset 'stylesheets/desktop/personal-notes.scss', :desktop
register_asset 'stylesheets/mobile/personal-notes.scss', :mobile

register_asset 'stylesheets/notebook.css'

load File.expand_path('../app/note_store.rb', __FILE__)

after_initialize do
  load File.expand_path('../app/controllers/notebook_controller.rb', __FILE__)
  load File.expand_path('../app/controllers/notes_controller.rb', __FILE__)

  Discourse::Application.routes.append do
    get '/notebook' => 'notebook#index'

    get '/notes' => 'notes#index'
    put '/notes/:note_id' => 'notes#update'
    delete '/notes/:note_id' => 'notes#destroy'
  end
end

# function call to receive the note from the store done using form
# display note as placeholder/input element value
# add index/id for the main notebook to all for indexing with the store
# make an initial function call that sets the notebook up when it gets initialized
#  - if note for the post/thing is not initialized, initialize it
#  - otherwise, call the post that was already there on initialization of the element