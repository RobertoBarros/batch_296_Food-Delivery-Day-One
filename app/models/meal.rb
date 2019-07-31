class Meal

  attr_reader :name, :price
  attr_accessor :id

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @price = attributes[:price]
  end
end


# bigmac = Meal.new(name: 'Big Mac', price: 18)
# name = bigmac.name

