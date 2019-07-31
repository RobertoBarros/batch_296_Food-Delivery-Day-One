require_relative '../views/orders_view'

class OrdersController

  def initialize(meal_repository, employee_repository, customer_repository, order_repository)
    @order_repository = order_repository
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @view = OrdersView.new
  end

  def list_undelivered_orders
    undelivered_orders = @order_repository.undelivered_orders
    @view.display(undelivered_orders)
  end

  def add
    # ask meal
    meal_id = @view.ask_meal_id
    meal = @meal_repository.find(meal_id)
    # ask customer
    customer_id = @view.ask_customer_id
    customer =  @customer_repository.find(customer_id)
    # ask employee
    employee_id = @view.ask_employee_id
    employee = @employee_repository.find(employee_id)

    # instanciate an order
    order = Order.new(meal: meal, customer: customer, employee: employee)

    # add order to order repository
    @order_repository.add(order)
  end

  def list_my_orders(employee)
    my_orders = @order_repository.all.select{ |order| order.employee.username == employee.username }

    @view.display(my_orders)
  end

  def mark_as_delivered(employee)
    # List all delivery guy undelivered orders
    # ask order id
    order_id = @view.ask_order_id
    order = @order_repository.find(order_id)
    # mask order as deliverd
    order.deliver!
    @order_repository.save
  end


end
