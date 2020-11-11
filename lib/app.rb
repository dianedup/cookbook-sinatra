require_relative 'cookbook'    # You need to create this file!
require_relative 'controller'  # You need to create this file!
require_relative 'router'
require_relative 'recipe'
require_relative 'view'

csv_file = File.join(__dir__, 'recipes.csv')
my_cookbook = Cookbook.new(csv_file)

controller = Controller.new(my_cookbook)

router = Router.new(controller)

# Start the app
router.run

# ------ initial tests
# # cookbook   = Cookbook.new(csv_file)

# Tester le modele
# recipe1 = Recipe.new("Carrot Cake", "Chop carrots and add brown sugar")
# p recipe1
# puts "Recipe 1 name is #{recipe1.name}"
# puts "Recipe 1 description is #{recipe1.description}"
# recipe2 = Recipe.new("Brownies", "Mix chocolate and sugar")
# recipe3 = Recipe.new("Lemon Cake", "4 lemons")

# # Next: Repository
# my_cookbook = Cookbook.new(csv_file)
# p my_cookbook

# p my_cookbook.all # => []
# my_cookbook.add_recipe(recipe4)
# # my_cookbook.add_recipe(recipe2)
# # my_cookbook.add_recipe(recipe3)
# # p my_cookbook.all # => [<Recipe1>, <Recipe2>, <Recipe3>]
# # my_cookbook.remove_recipe(0)
# # p my_cookbook.all # => [<Recipe2>, <Recipe3>]
# p my_cookbook.all
