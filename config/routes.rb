require_dependency "personal_notes_constraint"

PersonalNote::Engine.routes.draw do
  get "/" => "personal_notes#index", constraints: PersonalNoteConstraint.new
  get "/actions" => "actions#index", constraints: PersonalNoteConstraint.new
  get "/actions/:id" => "actions#show", constraints: PersonalNoteConstraint.new
end
