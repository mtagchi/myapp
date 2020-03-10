class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @participations = Participant.where(participant_user_id: @user.id).order('created_at DESC').paginate(page: params[:page], per_page: 5)
    @host_events = Event.where(host_user_id: @user.id).order('created_at DESC').paginate(page: params[:host_page], per_page: 5)
  end
end
