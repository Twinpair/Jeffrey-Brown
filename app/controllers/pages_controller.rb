class PagesController < ApplicationController
  def index
    @information = Information.first
    @services = Service.all
    #Counter is used to add a row div every 4 items
    @counter = 0
  end
end
