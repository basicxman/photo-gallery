class GalleriesController < ApplicationController
  before_filter :load_galleries, :except => [:destroy]
  before_filter :authenticate_user, :except => [:show, :index]

  def destroy
    gallery = Gallery.find_by_id(params[:id].to_i)
    if gallery.id == 1
      flash[:notice] = "Cannot get rid of main gallery."
    else
      gallery.destroy
    end
    redirect_to root_path
  end

  def create
    @gallery = Gallery.new(params[:gallery])
    if @gallery.save
      flash[:notice] = "New gallery created."
      blank_images
    else
      flash[:notice] = "Unable to create gallery."
    end
    respond_to do |format|
      format.html { render :show }
      format.js
    end
  end

  def index
  end

  def show
    @gallery = Gallery.find(params[:id].to_i)
    blank_images
  end

  def update
    @gallery = Gallery.find(params[:id].to_i)
    if @gallery.update_attributes(params[:gallery])
      flash[:notice] = "Updated gallery."
      blank_images
    else
      flash[:notice] = "Unable to update gallery."
    end
    render :show
  end

  private

  def blank_images
    3.times do
      @gallery.images.build
    end
  end

  def load_galleries
    @galleries = Gallery.latest_first
    @new_gallery = Gallery.new
  end
end
