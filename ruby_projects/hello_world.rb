class Customer
    @@no_of_customers = 0
    def initialize(id, name, addr)
        @cust_id = id
        @cust_name = name
        @cust_addr = addr
    end
   
    def print_id
        puts @cust_id.to_S
    end
    
    def print_name
        puts @cust_name.to_S
    end
    
    def print_addr
        puts @cust_addr.to_s
    end
    
    def print_all
        puts 'address: ' + print_addr + '\n' + 'name: ' + print_name +
            '\n' + 'id:' + print_id
    end
end

duck = Customer.new("gravy", "havy", "the_navy")

duck.print_all
duck.print_id
puts 'hello world!'
