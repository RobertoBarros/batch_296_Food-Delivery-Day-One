require_relative '../views/meals_view'

class MealsController

  def initialize(meal_repository)
    @meal_repository = meal_repository
    @view = MealsView.new
  end

  def list
    # get all meals
    meals = @meal_repository.all
    # show meals
    @view.display(meals)
  end

  def add
    # Ask name
    ask_name = @view.ask_name
    # Ask price
    ask_price = @view.ask_price
    # Instanciate a new meal
    meal = Meal.new(name: ask_name, price: ask_price)
    # Add meal to meal repository
    @meal_repository.add(meal)
  end


end
