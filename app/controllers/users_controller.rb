class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @attended_events = current_user.attended_events
  end 
end