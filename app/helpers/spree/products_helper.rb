module Spree
  module ProductsHelper
    # returns the formatted change in price (from the master price) for the specified variant (or simply return
    # the variant price if no master price was supplied)
    def variant_price_diff(variant)

      "(#{number_to_currency variant.price})"
    end

    def product_description(product)
      raw(product.description.gsub(/^(.*)$/, '<p>\1</p>'))
    end


  end
end