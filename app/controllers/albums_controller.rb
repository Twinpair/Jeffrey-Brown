class AlbumsController < ApplicationController
  
  before_action :authenticate, except: :show

  def index
    @albums = Album.all
    #Counter is used to add a row div every 4 items
    @counter = 0
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    if @album.order_listed.nil? 
      @album.order_listed = Album.count + 1
    end
    if @album.save
      Album.increment_order(@album.id, @album.order_listed)
      redirect_to album_path(@album.id, edit: true)
    else
      render :new
    end
  end

  def show
    #Counter is used to add a row div every 4 items
    @counter = 0
    @album = Album.find(params[:id])
    @photos = @album.photos
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    # Save order_listed attribute to update accoridingly later
    cache_order_listed = @album.order_listed
    if @album.update(album_params)
      if @album.order_listed.nil? 
        @album.order_listed = Album.count + 1
      end
      # Don't increment other order_listed attributes if order_listed is the same on the one being updated
      if cache_order_listed != @album.order_listed
        Album.increment_order(@album.id, @album.order_listed)
      end
      redirect_to album_path(@album.id, edit: true)
    else
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    Album.decrement_order(@album.id, @album.order_listed)
    @album.destroy
    redirect_to albums_path
  end

private

  def album_params
    params.require(:album).permit(:name, :description, :order_listed)
  end

end
