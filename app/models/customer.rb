class Customer < ActiveRecord::Base


    # has_many :orders, dependent: :destroy
    validates :name, length: { minimum: 10 }
    validates :email, presence: true, format: {with: /\A[^@\s]+@[^@\s]+\z/, message: "Enter the valid email address."}
    validates :phone, presence: true, format: {with: /\A[7-9][0-9]{9}\z/, message:"Enter the valid phone number."}
    validates :address, length: { minimum: 10 }


    def self.search(search)
        where("name LIKE ?", "%#{search}%")
    end

end
