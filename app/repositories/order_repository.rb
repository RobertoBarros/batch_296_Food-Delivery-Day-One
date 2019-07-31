require 'csv'
require_relative '../models/order'

class OrderRepository
  CSV_OPTIONS = {headers: :first_row, header_converters: :symbol}

  def initialize(csv_file, meal_repository, employee_repository, customer_repository)
    @csv_file = csv_file
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository

    @orders = []
    load if File.exists?(@csv_file)
    @next_id = @orders.empty? ? 1 : @orders.last.id + 1
  end

  def add(order)
    order.id = @next_id
    @orders << order
    save
    @next_id += 1
  end

  def find(id)
    @orders.select{ |order| order.id == id }.first
  end

  def all
    @orders
  end

  def undelivered_orders
    @orders.select { |order| !order.delivered? }
  end


  def load
    CSV.foreach(@csv_file, CSV_OPTIONS) do |row|

      meal_id = row[:meal_id].to_i
      meal = @meal_repository.find(meal_id)

      customer_id = row[:customer_id].to_i
      customer = @customer_repository.find(customer_id)

      employee_id = row[:employee_id].to_i
      employee = @employee_repository.find(employee_id)

      order = Order.new(id: row[:id].to_i, delivered: row[:delivered] == 'true', meal: meal, customer: customer, employee: employee)

      @orders << order
    end
  end

  def save
    CSV.open(@csv_file, 'wb', CSV_OPTIONS) do |csv|
      csv << %i[id delivered meal_id employee_id customer_id ]

      @orders.each do |order|
        csv << [order.id, order.delivered, order.meal.id, order.employee.id, order.customer.id]
      end
    end
  end


end