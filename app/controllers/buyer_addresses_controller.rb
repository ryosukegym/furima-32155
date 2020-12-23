class BuyerAddressesController < ApplicationController
  before_action :authenticate_user!,only: [:index]
  before_action :item_buyer,only: [:index,:create]


  def index
    @buyer_address = BuyerAddress.new
    if current_user.id==@item.user.id || @item.buyer!=nil
       redirect_to root_path
    end
    
  end

  def create
    @buyer_address = BuyerAddress.new(buyer_address_params)
    if @buyer_address.valid?
      pay_item
      @buyer_address.save
      redirect_to root_path
    else
      render 'index'
    end

  end

  private
  def buyer_address_params
     params.require(:buyer_address).permit(:postal_code,:prefectural_id,:city,:street,:building,:tel).merge(user_id: current_user.id,item_id: params[:item_id],token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
      Payjp::Charge.create( 
        amount: @item.price,
        card: buyer_address_params[:token],
        currency: 'jpy'
      )
  end
  def item_buyer
    @item = Item.find(params[:item_id])
  end
end

