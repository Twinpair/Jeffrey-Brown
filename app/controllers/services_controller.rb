class ServicesController < ApplicationController

  before_action :authenticate

  def index
    @services = Service.all
    #Counter is used to add a row div every 4 items
    @counter = 0
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    if @service.order_listed.nil? 
      @service.order_listed = Service.count + 1
    end
    if @service.save
      Service.increment_order(@service.id, @service.order_listed)
      redirect_to services_path 
    else
      render :new
    end
  end

  def edit
    @service = Service.find(params[:id])
  end

  def update
    @service = Service.find(params[:id])
    # Save order_listed attribute to update accoridingly later
    cache_order_listed = @service.order_listed
    if @service.update(service_params)
      if @service.order_listed.nil? 
        @service.order_listed = Service.count + 1
      end
      # Don't increment other order_listed attributes if order_listed is the same on the one being updated
      if cache_order_listed != @service.order_listed
        Service.increment_order(@service.id, @service.order_listed)
      end
      redirect_to services_path  
    else
      render :edit
    end
  end

  def destroy
    @service = Service.find(params[:id])
    Service.decrement_order(@service.id, @service.order_listed)
    @service.destroy
    redirect_to services_path
  end

private

  def service_params
    params.require(:service).permit(:title, :description, :icon, :order_listed)
  end

end
