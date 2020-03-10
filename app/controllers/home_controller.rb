class HomeController < ApplicationController
  def index
    @events = Event.limit(4).order('updated_at DESC')
  end
end
