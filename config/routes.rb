require_dependency "personal_notes_constraint"

PersonalNotes::Engine.routes.draw do
  get "/" => "personal_notes#index", constraints: PersonalNotesConstraint.new
  get "/actions" => "actions#index", constraints: PersonalNotesConstraint.new
  get "/actions/:id" => "actions#show", constraints: PersonalNotesConstraint.new
end
