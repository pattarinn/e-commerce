class ProductsController < ApplicationController
  before_action :authenticate_admin!, except: [:show, :index]

  def index
    @products = Product.all
    @products = @products.page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.csv { send_data generate_csv(Product.all), file_name: 'article.csv' }
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.create(product_params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @product = Product.find(params[:id])
    puts @product.status
    puts product_params
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def csv_upload
    data = params[:csv_file].read.split("\n")
    data.each do |line|
      attr = line.split(",").map(&:strip)
      p = Product.create title: attr[0], description: attr[1], stock: attr[2], price: attr[3]
      unless Category.exists?(name: attr[4])
        Category.create name: attr[4]
      end
      c = Category.where(name: attr[4])
      p.categories << c
    end
    redirect_to action: :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :description, :stock, :price, :status, :cover_image,
                                      category_ids: [], images: [])
    end

    def generate_csv(products)
      products.map { |p| [p.title, p.description, p.stock, p.price].join(',') }.join("\n")
    end

end
