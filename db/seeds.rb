require 'net/http'
require 'json'

uri_customers = URI("https://raw.githubusercontent.com/rst1211/Customer-Order-Management/JsonFiles/customers__list.json")
# uri_products = URI("https://raw.githubusercontent.com/rst1211/Customer-Order-Management/JsonFiles/products__lists.json")

response_customers = Net::HTTP.get(uri_customers)
# response_products = Net::HTTP.get(uri_products)

customer_list = JSON.parse(response_customers)
# produt_list = JSON.parse(response_products)

customer_list.length.times do |i| 

    customer = Customer.create(

        name: customer_list[i]["name"],
        email: customer_list[i]["email"],
        phone: customer_list[i]["phone"],
        address: customer_list[i]["address"]

    )
    puts "added #{customer_list[i]["name"]}"

end


# produt_list.length.times do |i| 

#     product = Product.create(

#         companyname: produt_list[i]["companyname"],
#         model: produt_list[i]["model"],
#         stock: produt_list[i]["stock"],
#         price: produt_list[i]["price"],
#         device: produt_list[i]["device"]


#     )
#     puts "added #{produt_list[i]["companyname"]}"

# end

