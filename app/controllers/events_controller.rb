class EventsController < ApplicationController
  before_action :sign_in_redirect, except: [:index, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @event = Event.new
    @event.current_step = @event.steps.first
  end

  def confirmarion
  end

  def create
    @event = current_user.events.build(event_params)
    @event.current_step = session[:event_step]
    if @event.first_step?
      if event_params["start_time(4i)"].blank?
        @event.start_time = nil
      end
      if event_params["end_time(4i)"].blank?
        @event.end_time = nil
      end
    end
    if @event.valid?
      if params[:back_button]
        @event.previous_step
      elsif @event.last_step?
        if event_params[:tag_list]
          tag_list = event_params[:tag_list].split(',')
        else
          tag_list = params[:tag_list].split(',')
        end
        @event.save && @event.save_tags(tag_list) if @event.all_valid?
      else
        @event.next_step
      end
      session[:event_step] = @event.current_step
    end
    if @event.new_record?
      render :new
    else
      session[:event_step] = nil
    end
  end

  def edit
    @event.current_step = session[:event_step]
    @tag_list = @event.tags.pluck(:name).join(',')
  end

  def update
    tag_list = @event.tags.pluck(:name).join(',')
    if @event.valid?
      if params[:back_button]
        @event.previous_step
      elsif @event.last_step?
        @event.update_attributes(session[:event_params]) && @event.save_tags(tag_list) if @event.all_valid?
      else
        @event.next_step
      end
      session[:event_step] = @event.current_step
    end
    session[:event_step] = session[:event_params] = nil
    redirect_to root_path
  end

  def destroy
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :text, :date, :start_time, :end_time, :no_of_participants, :tag_list, :restaurant_name, :address, :restaurant_url)
  end
end
