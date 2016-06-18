class Order < ActiveRecord::Base  
  belongs_to :order_status
  has_many :order_items
  has_one :delivery, dependent: :destroy

  before_create :set_order_status
  before_save :update_subtotal
  before_save :update_tax_shipping_total
  
  def subtotal
  	order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

  def tax
    subtotal / 11
  end

  def shipping
    return 0
  end

  def total
    subtotal + shipping
  end

  private

  	def set_order_status
  		self.order_status_id = 1
  	end

  	def update_subtotal
  		self[:subtotal] = subtotal        
  	end

    def update_tax_shipping_total
      self[:tax] = tax
      self[:shipping] = shipping
      self[:total] = total
    end

end
