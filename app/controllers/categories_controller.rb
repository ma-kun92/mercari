class CategoriesController < ApplicationController
  before_action :header_menu,only: [:index,:show]
  add_breadcrumb 'メルカリ', :root_path
  add_breadcrumb 'カテゴリー一覧', :categories_path

  def index
  end

  def show
    @category = Category.find(params[:id])
    @child_categories = Category.children_of(@category).order("RAND()").limit(9)
    #一覧に表示するアイテムを取得（ログイン時、本人出品物は表示しない）
    progeny_category = Category.subtree_of(@category)
    sold_item = Deal.pluck('item_id')
    indicate_items = Item.includes(:category).where(categories:{id:progeny_category.ids}).where.not(id:sold_item).order(id: :DESC)
    if user_signed_in? && Vendor.find_by(user_id:current_user.id)
      my_vendor = Vendor.find_by(user_id:current_user.id)
      @items = indicate_items.where.not(vendor_id:my_vendor.id)
    else
      @items = indicate_items
    end
    #パンくずリストの表示
    @category.ancestors.each do |category|
      add_breadcrumb category.name, "#{category.id}"
    end
    add_breadcrumb @category.name
  end
end
