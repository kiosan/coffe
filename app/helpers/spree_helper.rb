
module SpreeHelper
  def link_to_cart(text = t('cart'))
    return "" if current_page?(cart_path)
    text = "<span class='cart-count'>#{current_order ? current_order.item_count: 0}</span> #{text}"
    if current_order.nil? or current_order.line_items.empty?
      text = "#{text}"
    else
      text = "#{text}" # : (#{current_order.item_count}) #{order_price(current_order)}"
      
    end
    link_to raw(text), cart_path, :class => "top-link-cart"
  end
  
  def breadcrumbs(taxon, separator="&nbsp;&raquo;&nbsp;")
    return "" if current_page?("/") || taxon.nil?
    separator = raw(separator)
    crumbs = [content_tag(:li, link_to(t(:home) , root_path) + separator)]
    if taxon
      crumbs << content_tag(:li, link_to(t('products') , products_path) + separator)
      crumbs << taxon.ancestors.collect { |ancestor| content_tag(:li, link_to(ancestor.name , seo_url(ancestor)) + separator, :class=>"category5") } unless taxon.ancestors.empty?
      crumbs << content_tag(:li, taxon.name, :class=>"category7")
    else
      crumbs << content_tag(:li, content_tag(:span, t('products')))
    end
    crumb_list = content_tag(:ul, raw(crumbs.flatten.map{|li| li.mb_chars}.join), :class=>"breadcrumbs")
    content_tag(:div, crumb_list, :id => 'breadcrumbs')
  end
    
  # returns the price of the product to show for display purposes
  def product_price(product_or_variant, options={})
    amount = product_or_variant.price
    options.reverse_merge! :format_as_currency => true  
    if product_or_variant.kind_of? Variant
      currency = product_or_variant.product.currency
    else
      currency = product_or_variant.currency
    end
    p "-------------------"
    p options
    options.delete(:format_as_currency) ? format_price(amount, {:currency=>currency}) : amount
  end

  def variant_price_diff(v)

    number_to_currency variant.price
    
  end
  
  def format_price(price, options={})
    formatted_price = number_to_currency price, :locale => options[:currency] == "EUR" ? :fr : I18n.locale
    formatted_price
  end

  # human readable list of variant options
    def variant_options(v, allow_back_orders = Spree::Config[:allow_backorders], include_style = true)
      
      list = v.options_text

      # We shouldn't show out of stock if the product is infact in stock
      # or when we're not allowing backorders.
      unless (allow_back_orders || v.in_stock?)
        list = if include_style
          content_tag(:span, "(#{t(:out_of_stock)}) #{list}", :class => 'out-of-stock')
        else
          "#{t(:out_of_stock)} #{list}"
        end
      end

      list
    end
end
