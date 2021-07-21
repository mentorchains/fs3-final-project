# frozen_string_literal: true

# name: PersonalNotes
# about: store personal notes
# version: 0.1
# authors: STEMAWAY/FS3-JUNE
# url: 

register_asset 'stylesheets/common/personal-notes.scss'
register_asset 'stylesheets/desktop/personal-notes.scss', :desktop
register_asset 'stylesheets/mobile/personal-notes.scss', :mobile

enabled_site_setting :personal_notes_enabled

PLUGIN_NAME ||= 'PersonalNote'

load File.expand_path('lib/personal-notes/engine.rb', __dir__)

after_initialize do
  # https://github.com/discourse/discourse/blob/master/lib/plugin/instance.rb
end
