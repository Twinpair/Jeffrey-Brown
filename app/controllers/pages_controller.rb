class PagesController < ApplicationController

  before_action :authenticate, only: [:edit]
  
  def index
    @information = Information.first
    @services = Service.all
    @albums = Album.all
    @message = Message.new
    #Counter is used to add a row div
    @counter = 0
  end

  def edit
  end

end
