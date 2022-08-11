class EventsController < ApplicationController

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
    @event = current_user.events.find(params[:id])
  end

  def attend
    @event = Event.find(params[:id])
    if @event.attendees.include?(current_user)
      redirect_to @event, notice: "You have already registered for this event"
    else
      @event.attendees << current_user
      redirect_to @event, notice: "You are now registered for this event!"
    end
  end

  private
  def event_params
    params.require(:event).permit(:date, :location)
  end
end
