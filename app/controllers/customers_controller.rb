require_relative '../views/customers_view'

class CustomersController

  def initialize(customer_repository)
    @customer_repository = customer_repository
    @view = CustomersView.new
  end

  def list
    # get all customers
    customers = @customer_repository.all
    # show customers
    @view.display(customers)
  end

  def add
    # Ask name
    ask_name = @view.ask_name
    # Ask price
    ask_address = @view.ask_address
    # Instanciate a new customer
    customer = Customer.new(name: ask_name, address: ask_address)
    # Add customer to customer repository
    @customer_repository.add(customer)
  end


end
