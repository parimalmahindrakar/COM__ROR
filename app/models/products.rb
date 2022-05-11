class Products < ActiveRecord::Base

    validates :CompanyName, presence: true,length: { minimum: 10 }
    validates :Model, presence: true, length: { minimum: 10 }
    validates :device,presence: true, presence: true, length: { minimum: 10 }
    validates :stock,  presence: true, numericality: { only_integer: true }
    validates :price, presence: true, numericality: { only_integer: true }



end
