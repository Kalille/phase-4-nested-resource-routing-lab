class ItemsController < ApplicationController

  def index
    items = Item.all
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
     
      return render json: {error: "user not found"}, status: :not_found unless user


        items = user.items
    else
    items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item = find_item
    if item
      render json: item
    else
      render json: {error: "item not found"}, status: :not_found
    end
  end


  def create
    user = User.find_by(id: params[:user_id])
    if user
    item = user.items.create(item_params)

    render json: item, status: :created

    else
      render json: {error: " User not found"}, status: :not_found
    end

   
  end

  private

  def find_item
    @item = Item.find_by(id: params[:id])
  end

  def item_params
    params.permit(:name,:description, :price)
  end



end
