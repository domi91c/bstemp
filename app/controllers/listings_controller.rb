class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  # before_action :verify_authorized!


  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.includes(:images).where.not(:images => {:image => nil})
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
    @test_listing = Listing.last
  end

  # POST /listings
  # POST /listings.json
  # def create
  #   @listing = current_user.listings.build(listing_params)
  #
  #   respond_to do |format|
  #     if @listing.save
  #       format.html {redirect_to @listing, notice: 'Listing was successfully created.'}
  #       format.json {render :show, status: :created, location: @listing}
  #     else
  #       format.html {render :new}
  #       format.json {render json: @listing.errors, status: :unprocessable_entity}
  #     end
  #   end
  # end

  def create
    @listing = current_user.listings.new
    @listing.save(validate: false)
    redirect_to listing_build_path(@listing, Listing.form_steps.first)
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html {redirect_to @listing, notice: 'Listing was successfully updated.'}
        format.json {render :show, status: :ok, location: @listing}
      else
        format.html {render :edit}
        format.json {render json: @listing.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html {redirect_to listings_url, notice: 'Listing was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_listing
    @listing = Listing.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def listing_params
    params.require(:listing).permit(:title, :body, :tagline, :price, :quantity, :images_attributes => [:image_id, :image])
  end
end