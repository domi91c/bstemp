module ProductsHelper
  def cart_button_string(product)
    if Cart[current_user].lines[product]
      str = "Update Cart"
    else
      str = "Add to Cart"
    end
    str
  end

  def quantity_field_value(product)
    unless quantity = Cart[current_user].lines[product]
      quantity = 1
    end
    quantity
  end

  def favorites_count(product)
    Favorite.where(product_id: product.id).count
  end

  def sales_count(product)
    Purchase.where(product_id: product.id).count
  end

  def view_count(product)
    product.impressions ||= 0
  end

  def cover_image(product)
    product.images.last.processed_url
  end
end
