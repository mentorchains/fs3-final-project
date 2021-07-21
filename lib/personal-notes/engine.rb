module PersonalNote
  class Engine < ::Rails::Engine
    engine_name "PersonalNote".freeze
    isolate_namespace PersonalNote

    config.after_initialize do
      Discourse::Application.routes.append do
        mount ::PersonalNote::Engine, at: "/personal-notes"
      end
    end
  end
end
