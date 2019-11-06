class HomeController < ApplicationController
  def index
    @events = Event.limit(4).order('created_at DESC')
  end
end
