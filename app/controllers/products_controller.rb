class ProductsController < ApplicationController
  before_action :set_product, only: [ :edit, :update, :show, :destroy ]
  allow_unauthenticated_access only: [ :index, :show ]

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "Product successfully created"
      redirect_to @product
    else
      flash[:error] = "Something went wrong"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      flash[:success] = "Product was successfully updated"
      redirect_to @product
    else
      flash[:error] = "Something went wrong"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = "Product was successfully deleted."
      redirect_to products_path
    else
      flash[:error] = "Something went wrong"
      redirect_to products_path
    end
  end


  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :featured_image, :inventory_count)
    end
end
