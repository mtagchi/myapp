class EventsController < ApplicationController
  before_action :sign_in_redirect, except: [:index, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    session[:event_params] ||= {}
    @event = Event.new
    @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
  end

  def create
    session[:event_params].deep_merge!(event_params)
    @event = current_user.events.build(session[:event_params])
    @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
    @event.current_step = session[:order_step]
    if @event.valid?
      if params[:back_button]
        @event.previous_step
      elsif @event.last_step?
        @event.save if @event.all_valid?
      else
        @event.next_step
      end
      session[:event_step] = @event.current_step
    end
    if @event.new_record?
      render :new
    else
      session[:event_step] = session[:event_params] = nil
      redirect_to @event
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end
  def event_params
    params.require(:event).permit(:title, :date, :start_time, :end_time, :no_of_participants, :text, :restaurant_name, :address, :restaurant_url, :tag_list)
  end
end
