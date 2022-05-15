class Order < ActiveRecord::Base
    belongs_to :customer
    belongs_to :product

    validates :quantity,  presence: true, numericality: {
        only_integer: true,
        greater_than: 0
    }
    validates :status, presence: true
    validates :customer_id, presence: true
    validates :product_id, presence: true


    def self.search(search)
        where( "%#{search}%"    ,"LIKE ?", "%#{search}%")
    end

end
