module PersonalNotes
  class Engine < ::Rails::Engine
    engine_name "PersonalNotes".freeze
    isolate_namespace PersonalNotes

    config.after_initialize do
      Discourse::Application.routes.append do
        mount ::PersonalNotes::Engine, at: "/personal-notes"
      end
    end
  end
end
