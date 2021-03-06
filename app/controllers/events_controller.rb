class EventsController < ApplicationController
  before_action :sign_in_redirect, except: [:index, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy, :participate, :cancel]

  def index
    date_ids = DatetimeOption.
      select("DISTINCT ON (event_id) id").
      order(:event_id, date: :desc)
    @events = Event.
      joins(:datetime_options).
      where("datetime_options.id": date_ids).
      order(date: :desc).paginate(page: params[:page], per_page: 20)
  end

  def show
    @host_user = User.find(@event.host_user_id)
    @participants = Participant.where(event_id: @event.id)
    @comment = Comment.new
    @comments = @event.comments
  end

  def new
    @event = Event.new
    @datetime_option = @event.datetime_options.build
    @event.current_step = session[:event_step] = @event.steps.first
  end

  def create
    @event = current_user.events.build(event_params)
    @datetime_option = @event.datetime_options.build(datetime_option_params)
    @event.current_step = session[:event_step]
    if @event.first_step?
      @datetime_option.start_time = nil if datetime_option_params["start_time(4i)"].blank?
      @datetime_option.end_time = nil if datetime_option_params["end_time(4i)"].blank?
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
        if @event.all_valid?
          @event.save
          @event.save_tags(tag_list)
          @event.participants.create(participant_user_id: current_user.id)
        end
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
    @event.current_step = @event.steps.first
    @tag_list = @event.tags.pluck(:name).join(',')
  end

  def update
    if @event.host_user_id == current_user.id
      @event.start_time = nil if event_params["start_time(4i)"].blank?
      @event.end_time = nil if event_params["end_time(4i)"].blank?
      if @event.valid?
        if event_params[:tag_list]
          tag_list = event_params[:tag_list].split(',')
        else
          tag_list = params[:tag_list].split(',')
        end
        @event.update(event_params) && @event.save_tags(tag_list)
      end
    end
  end

  def destroy
    if @event.host_user_id == current_user.id
      @event.destroy
      redirect_to root_path
    end
  end

  def participate
    @event.participants.create(participant_user_id: current_user.id)
    redirect_to @event
  end

  def cancel
    @participant = @event.participants.find_by(participant_user_id: current_user.id)
    @participant.destroy
    redirect_to @event
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
      :title,
      :text,
      :no_of_participants,
      :tag_list,
      :restaurant_name,
      :address,
      :restaurant_url,
    )
  end

  def datetime_option_params
    params.permit(:id, :date, :start_time, :end_time, :_destroy)
  end
end
