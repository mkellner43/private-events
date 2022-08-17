class EventsController < ApplicationController
before_action :authenticate_user!, :except => [:index]
before_action :is_creator, :except => [:index, :show, :attend, :unattend, :new ]
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to @event, notice: 'Successfully created'
    else
      render :new, notice: 'Something went wrong'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = current_user.events.find(params[:id])
    if @event.update(event_params)
      redirect_to root_path, notice:"Successfully updated"
    else
      redirect_to root_path, notice: "Something went wrong", status: :unprocessable_entity
    end 
  end

  def destroy
    @event = current_user.events.find(params[:id])
    @event.destroy
    redirect_to root_path, notice: "Event succesfully deleted!", status: :see_other
  end

  def attend
    @event = Event.find(params[:id])
    if @event.attendees.include?(current_user)
      redirect_to @event, alert: "You have already registered for this event"
    else
      @event.attendees << current_user
      redirect_to @event, notice: "You are now registered for this event!"
    end
  end

  def unattend
    @event = Event.find(params[:id])
    @event.attendees.delete(current_user)
    redirect_to @event, notice: "Successfully unregistered!"
  end

  private
  def event_params
    params.require(:event).permit(:date, :time, :location, :details)
  end

  def is_creator
    unless Event.find(params[:id]).creator_id == current_user.id
      redirect_to root_path, alert: "Unauthorized user"
    end 
  end 
end
