
Spree::Order.class_eval do

  before_validation :clone_shipping_address
  def clone_shipping_address
    if ship_address
      if ship_address and self.bill_address.nil?
        self.bill_address = ship_address.clone
      else
        self.bill_address.attributes = ship_address.attributes.except('id', 'updated_at', 'created_at')
      end
    end
    true  
  end
end
