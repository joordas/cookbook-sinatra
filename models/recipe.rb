class Recipe
  attr_reader :name, :description, :cooking_time, :tested, :difficulty

  def initialize(args = {})
    @name = args[:name]
    @description = args[:description]
    @cooking_time = args[:cooking_time]
    @tested = false
    @difficulty = args[:difficulty]
  end

  def mark_as_tested!
    @tested = true
  end
end
