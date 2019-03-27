module CategoriesHelper
  def children_category_define(parent_category)
    @children_categories = Category.children_of(parent_category)
  end
end
