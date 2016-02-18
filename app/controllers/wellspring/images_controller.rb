require_dependency "wellspring/application_controller"

module Wellspring
  class ImagesController < ApplicationController
    def index
      @images = Image.order('id desc')
    end

    def show
      @image = Image.find(params[:id])
    end

    def create
      @image = Image.new(image: params[:file])

      if @image.save
        render plain: @image.image.url, :status => 200
      else
        render json: { error: @image.errors.full_messages.join(',')}, :status => 400
      end
    end

    def destroy
      @image = Image.find(params[:id])
      @image.destroy
      redirect_to images_path, notice: 'Image was successfully destroyed.'
    end
  end
end
