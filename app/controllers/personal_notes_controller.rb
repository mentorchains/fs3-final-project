require_dependency 'application_controller'
class PersonalNotesController < ApplicationController
  before_action :ensure_logged_in
  def index
  end
end