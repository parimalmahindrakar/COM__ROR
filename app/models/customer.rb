class Customer < ActiveRecord::Base
    validates :name, length: { minimum: 10 }
    validates :email, presence: true, format: {with: /\A[^@\s]+@[^@\s]+\z/, message: "Enter the valid email address."}
    validates :phone, presence: true, format: {with: /\A[7-9][0-9]{9}\z/, message:"Enter the valid phone number."}
    validates :address, length: { minimum: 10 }

end
