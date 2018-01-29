class PhotosController < ApplicationController

  before_action :authenticate

  def new
    @photo = Photo.new
    @photo.album_id = params["album_id"] if params["album_id"]
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.album_id = params["album_id"].to_i 
    if @photo.order_listed.nil? 
      @photo.order_listed = Album.find(@photo.album_id).photos.count + 1
    end
    if @photo.save
      Photo.increment_order(@photo.id, @photo.order_listed)
      redirect_to album_path(@photo.album_id, edit: true)
    else
      render :new
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    @photo.album_id = params["album_id"].to_i 
    # Save order_listed attribute to update accoridingly later
    cache_order_listed = @photo.order_listed
    if @photo.update(photo_params)
      if @photo.order_listed.nil? 
        @photo.order_listed = Album.find(@photo.album_id).photos.count + 1
      end
      # Don't increment other order_listed attributes if order_listed is the same on the one being updated
      if cache_order_listed != @photo.order_listed
        Photo.increment_order(@photo.id, @photo.order_listed)
      end
      redirect_to album_path(@photo.album_id, edit: true)  
    else
      render :edit
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    Photo.decrement_order(@photo.id, @photo.order_listed)
    @photo.destroy
    redirect_to album_path(@photo.album_id, edit: true)
  end

private

  def photo_params
    params.require(:photo).permit(:title, :description, :image, :order_listed, :album_id)
  end

end
