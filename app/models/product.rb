class Product < ActiveRecord::Base

    has_many :orders, dependent: :destroy
    
    validates :companyname, presence: true
    validates :device,presence: true
    validates :stock,  presence: true, numericality: {
            only_integer: true,
            greater_than_or_equal_to: 0
    }
    validates :price, presence: true, numericality: {
        only_integer: true,
        greater_than_or_equal_to: 0
    }


    validates :model, 
          :presence => {:message => "can't be blank." },
          :uniqueness => {:message => "already exists."}

    def self.search(search)
        where("CompanyName LIKE ?", "%#{search}%")
    end

    def self.returnProduct(product_id)
        Product.find_by(id:product_id)
    end

end
