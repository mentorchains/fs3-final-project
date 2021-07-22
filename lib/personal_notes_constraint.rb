class PersonalNotesConstraint
  def matches?(request)
    SiteSetting.personal_notes_enabled
  end
end
