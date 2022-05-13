class Product < ActiveRecord::Base

    validates :companyname, presence: true
    validates :model, presence: true
    validates :device,presence: true
    validates :stock,  presence: true, numericality: { only_integer: true }
    validates :price, presence: true, numericality: { only_integer: true }

    def self.search(search)
        where("CompanyName LIKE ?", "%#{search}%")
    end

end
