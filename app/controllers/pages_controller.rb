class PagesController < ApplicationController
  def index
    @services = Service.all
    #Counter is used to add a row div every 4 items
    @counter = 0
  end
end
