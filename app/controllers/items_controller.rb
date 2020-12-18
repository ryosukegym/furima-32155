class ItemsController < ApplicationController
  # belongs_to_active_hash :region
  before_action :move_to_index, only: [:new]

  def index
    @items = Item.all.includes(:user)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end
  

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
    # @item.update(item_params)
    # if user_signed_in? 
    #   if current_user.id==@item.user.id
    #     redirect_to edit_item_path
    #   end
    # else
    #   render :index
    end
  end
  private

  def item_params
    params.require(:item).permit(:title, :explanation, :category_id, :product_condition_id, :delivery_fee_id, :prefectural_id,
                                 :day_to_ship_id, :price, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
    redirect_to new_user_session_path
    end
  end
