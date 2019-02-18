require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'cookbook'
require_relative 'recipe'

set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

csv_file = File.join(__dir__, 'recipes.csv')
my_cookbook = Cookbook.new(csv_file)

# READ
get '/' do
  # Ask the Cookbook repository to return all the recipes
  @recipes = my_cookbook.all
  # Ask the View to display the recipes to the user
  erb :index
end

# CREATE - step 1
get '/new' do
  # Ask View to ask user for the name and description of the new recipe
  erb :new
end
# CREATE - step 2
post '/recipes' do
  # Create a recipe object with these details return in a hash 'params'
  recipe = Recipe.new(params[:name], params[:description])
  # Ask the Cookbook repository to store this new recipe
  my_cookbook.add_recipe(recipe)

end

get '/about' do
  erb :about
end

get '/team/:username' do
  puts params[:username]
  "The username is #{params[:username]}"
end

# --- TO REMEMBER ---
# 1) get '/' do  # <- Router part
#   # [...]   #
#   # [...]   # <- Controller part
#   # [...]   #
# end

# 2) params can be filled from 3 places:
#   - Routing parameters (like /team/:username)
#   - Query string parameters (if the URL is like /search?keyword=lewagon)
#   - Body from HTTP POST queries (coming from <form action="post" />)

# 3) view file extension is .erb. It means Embedded RuBy.
# -> So you don't have to limit yourself to plain HTML in here,
# you can also write Ruby code and output it!

# 4) you can use <% %> or <%= %> :
# The former won't output the result of your Ruby code inside the HTML.
# Useful for .each blocks

# 5) in views/layout.erb: <%= yield %>
# => It's where your specific view will be inserted.
