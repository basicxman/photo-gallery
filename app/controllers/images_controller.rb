class ImagesController < ApplicationController
  respond_to :js, :only => [:show]

  def new
    @image = Image.new(params[:image])
  end

  def create
    @image = Image.new(params[:image])
    if @image.save
      flash[:notice] = "Image created!"
      redirect_to gallery_path(@image.gallery)
    else
      flash[:notice] = "Unable to create image."
      render :new
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    respond_to do |format|
      format.html { redirect_to gallery_path(@image.gallery) }
      format.js
    end
  end

  def update
    @image = Image.find(params[:id])
    if @image.update_attributes(params[:image])
      flash[:notice] = "Image updated!"
    else
      flash[:notice] = "Unable to update the image."
    end
    render :show
  end

  def show
    @image = Image.find(params[:id])
  end

  def index
    @images = Image.latest_first
  end
end
