class Products::ImagesController < ApplicationController
  # before_action :set_product, only: [:create, :index]

  def index
    @images = Product.find(params[:product_id]).images
    render json: { images: @images.order(:updated_at).reverse }, status: :ok
  end

  def create
    @image = Product.find(params[:product_id]).images.build(image_params)
    if @image.save
      render json: { image: @image }, status: :created
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  def update
    @image = Image.find(params[:id])
    if @image.update(image_params)
      @image.set_urls
      render json: { image: @image }, status: :created
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    head :no_content
  end

  def set_cover_image
    @image = Image.find(params[:id])
    @product = Product.find(params[:product_id])
    @images = @product.images
    @images.map { |image| image.cover_image = false; image.save }
    @image.cover_image = true
    @image.save
    head :no_content
  end

  private

  def set_product
    Product.find(params[:product_id])
  end

  def image_params
    params.require(:image).permit(:attachment, :crop_x, :crop_y, :crop_width, :crop_height)
  end

end
