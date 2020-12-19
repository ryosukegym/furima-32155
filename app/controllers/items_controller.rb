class ItemsController < ApplicationController
  before_action :authenticate_user!,only: [:new,:edit]
  # before_action :move_to_index, only: [:new,:edit]
  # 下記理由記載
  before_action :item_find, only: [:update,:show,:edit]
  before_action :item_user, only: [:edit,:update]

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
  end

  def edit
  end
  

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end
  private

  def item_params
    params.require(:item).permit(:title, :explanation, :category_id, :product_condition_id, :delivery_fee_id, :prefectural_id,
                                 :day_to_ship_id, :price, :image).merge(user_id: current_user.id)
  end

  # def move_to_index
  #   unless user_signed_in?
  #   redirect_to new_user_session_path
  #   end
  # 残している理由、authenticate_userに変えていることをお思い出すため！！！
  end

  def item_find
    @item = Item.find(params[:id])
  end

  def item_user
    if current_user.id!=@item.user.id
      redirect_to root_path
    end
  end
end
