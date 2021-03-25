class CategoryController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
  end

  def edit
    @category = Category.find(params[:id])
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to :controller => 'products', :action => 'index'
  end

  def update
    @category = Category.find(params[:id])
    @category.update(category_params)
    # redirect_to :controller => 'products', :action => 'index' # back to product index page
    redirect_to action: :show
  end

  def show
    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end

end