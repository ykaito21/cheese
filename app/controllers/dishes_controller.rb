class DishesController < ApplicationController
  before_action :set_dish, only: [ :show, :edit, :update, :destroy ]

  def index
    if params[:query].present? || params[:category].present?
      sql_query = "name ILIKE :query AND category ILIKE :category"
      @dishes = Dish.where(sql_query, query: "%#{params[:query]}%", category: "%#{params[:category]}%")
    else
      @dishes = Dish.all.sort_by { |dish| - dish.id }
    end
  end

  def show
    @restaurant = @dish.restaurant
    @order = Order.new
    @markers = [{ lat: @restaurant.latitude, lng: @restaurant.longitude }]
  end

  def new
    @dish = Dish.new
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def create
    @dish = Dish.new(dish_params)
    @restaurant = Restaurant.find(params[:restaurant_id])
    @dish.restaurant = @restaurant
    if @dish.save
      redirect_to dish_path(@dish)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @dish.update(dish_params)
      redirect_to dish_path(@dish)
    else
      render :edit
    end
  end

  def destroy
    @dish.destroy
    redirect_to root_path
  end


  private

  def dish_params
    params.require(:dish).permit(:name, :description, :photo, :price, :category)
  end

  def set_dish
    @dish = Dish.find(params[:id])
  end
end
