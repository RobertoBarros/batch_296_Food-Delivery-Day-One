class OrdersView

  def ask_meal_id
    puts "Enter meal id:"
    gets.chomp.to_i
  end

  def ask_customer_id
    puts "Enter customer id:"
    gets.chomp.to_i
  end

  def ask_employee_id
    puts "Enter employee id:"
    gets.chomp.to_i
  end

  def ask_order_id
    puts "Enter order id:"
    gets.chomp.to_i
  end

  def display(orders)
    orders.each do |order|
      puts "#{order.id} | Employee: #{order.employee.username} | Customer: #{order.customer.name} | Meal: #{order.meal.name}"
    end
  end

end