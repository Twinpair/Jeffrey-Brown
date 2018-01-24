class PagesController < ApplicationController
  def index
    @information = Information.first
    @services = Service.all
    @photos = Photo.all
    #Counter is used to add a row div
    @counter = 0
  end
end
