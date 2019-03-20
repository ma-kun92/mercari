class ItemsController < ApplicationController
  before_action :header_menu,only: [:index,:show]

  def index
  end

  def new
    @item = Item.new
    @item.item_images.build
    @brands = Brand.all
    gon.middle = Category.where(id:[15..153])
    gon.small  = Category.where(id:[154..1212])
    gon.size = Size.all
  end

  def create
    @item = Item.new(item_params)
      if @item.save
        params[:image].each do |image|
          @item.item_images.create(image: image)
      end
        redirect_to root_path
      else
        render 'new'
      end
  end

  def show
    @item = Item.find(params[:id])
    @images = @item.item_images
    @comment = ItemComment.new
    @comments = @item.item_comments
    sold_item = Deal.pluck('item_id')
    @vendor_items = Item.where.not('id=? or id=?',params[:id],sold_item).where(vendor_id:@item.vendor_id).order(id: :DESC).limit(6)
    @brand_items = Item.where.not('id=? or id=?',params[:id],sold_item).where(brand:@item.brand).order(id: :DESC).limit(6)
  end

  def image
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy if item.vendor_id == current_user.id
    redirect_to users_path
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy if item.vendor_id == current_user.id
    redirect_to users_path
  end

  private
  def item_params
    params.require(:item).permit(:name,:description,:price,:condition,:shipping_fee,:shipping_date,:shipping_method,:prefecture_id,:size_id,:category_id,:brand,
      item_images_attributes: [:image])

  end
end
