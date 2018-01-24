class PhotosController < ApplicationController
  def index
    @photos = Photo.all
    #Counter is used to add a row div every 4 items
    @counter = 0
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.order_listed.nil? 
      @photo.order_listed = Photo.count + 1
    end
    if @photo.save
      Photo.increment_order(@photo.id, @photo.order_listed)
      redirect_to photos_path 
    else
      render :new
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    # Save order_listed attribute to update accoridingly later
    cache_order_listed = @photo.order_listed
    if @photo.update(photo_params)
      if @photo.order_listed.nil? 
        @photo.order_listed = Photo.count + 1
      end
      # Don't increment other order_listed attributes if order_listed is the same on the one being updated
      if cache_order_listed != @photo.order_listed
        Photo.increment_order(@photo.id, @photo.order_listed)
      end
      redirect_to photos_path  
    else
      render :edit
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    Photo.decrement_order(@photo.id, @photo.order_listed)
    @photo.destroy
    redirect_to photos_path
  end

private

  def photo_params
    params.require(:photo).permit(:title, :description, :image, :order_listed)
  end

end
