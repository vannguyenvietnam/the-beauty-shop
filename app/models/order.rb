class Order < ActiveRecord::Base  
  belongs_to :order_status
  has_many :order_items
  before_create :set_order_status
  before_save :update_subtotal
  before_save :update_tax_shipping_total
  
  def subtotal
  	order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

  private

  	def set_order_status
  		self.order_status_id = 1
  	end

  	def update_subtotal
  		self[:subtotal] = subtotal        
  	end

    def update_tax_shipping_total
      self[:tax] = subtotal / 11
      self[:shipping] = 0
      self[:total] = subtotal + self[:shipping].to_i
    end

end
