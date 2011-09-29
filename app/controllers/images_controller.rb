class ImagesController < ApplicationController
  respond_to :js, :only => [:show, :batch_destroy]

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

  def batch_destroy
    @images = Image.find(get_batch)
    @images.each(&:destroy)
  end

  def batch_move
    @images = Image.find(get_batch)
    @gallery = @images.first.gallery
    @images.each { |i| i.update_attribute(:gallery_id, params[:destination].to_i) }
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

  private

  def get_batch
    params[:batch].split(",").map { |i| i.to_i }
  end
end
