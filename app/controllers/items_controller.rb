class ItemsController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :create, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def index
    @items = if params[:search_term]
      if Rails.env.production?
        Item.where('brand ILIKE ? OR model ILIKE ?', "%#{params[:search_term]}", "%#{params[:search_term]}").paginate(page: params[:page])
      else
        Item.where('brand LIKE ? OR model LIKE ?', "%#{params[:search_term]}", "%#{params[:search_term]}").paginate(page: params[:page])
      end
    else
      Item.paginate(page: params[:page])
    end
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      flash[:success] = "Item created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      # handle update_attributes
    else
      render 'edit'
    end
  end

  def destroy
    @item.destroy
    flash[:success] = "Item deleted from your library"
    redirect_to request.referrer || root_url
  end

  private

    def item_params
      params.require(:item).permit(:brand, :model, :ssn, :cost, :picture, :search_term)
    end

    def correct_user
      @item = current_user.items.find_by(id: params[:id])
      redirect_to root_url if @item.nil?
    end
end
