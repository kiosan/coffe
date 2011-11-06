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
end
