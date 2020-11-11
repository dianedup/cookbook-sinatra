require_relative 'view'
require_relative 'cookbook'
require_relative 'scrape_marmiton_service'
require 'nokogiri'
require 'open-uri'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view     = View.new
  end

  def create
    # Ask View to ask user for the name and description of the new recipe
    recipe_details = @view.ask_user_for_recipe_details
    # Create a recipe object with these details
    recipe = Recipe.new(recipe_details[:name], recipe_details[:description])
    # Ask the Cookbook repository to store this new recipe
    @cookbook.add_recipe(recipe)
  end

  def list
    # Ask the Cookbook repository to return all the recipes
    recipes = @cookbook.all
    # Ask View to display the recipes to the user
    @view.display_all(recipes)
  end

  def destroy
    # Display list of recipes
    list
    # Ask View to ask user for the index of the recipe to delete
    index_recipe = @view.ask_user_for_recipe_index
    # Ask the Cookbook repository to remove this recipe
    @cookbook.remove_recipe(index_recipe)
    # Display new list of recipes
    list
  end


  def import_recipes_from_marmition
    # Ask View to ask user for an ingredient
    ingredient = @view.ask_user_for_ingredient

    # Ask View to ask user for an optional difficulty filter
    difficulty = @view.ask_user_for_difficulty_level

    # Scrape recipes from Marmiton corresponding to this ingredient
    recipes = scrape_recipes_from_marmiton(ingredient, difficulty)

    # Ask View to display the imported recipes with indexes
    @view.display_imported_recipes(recipes)
    # Ask View to ask user the index of the recipe he/she wants to import
    index_recipe = @view.ask_user_for_recipe_index
    # Create a recipe object with these details
    recipe_details = recipes[index_recipe]
    recipe = Recipe.new(recipe_details[:name], recipe_details[:description],
                        recipe_details[:link], recipe_details[:prep_time], recipe_details[:difficulty])
    # Ask the Cookbook repository to store this new recipe
    @cookbook.add_recipe(recipe)
    # Display new list of recipes
    list
  end

  def scrape_recipes_from_marmiton(ingredient, difficulty)
    # Initialize a scraping service
    scraping_service = ScrapeMarmitonService.new(ingredient, difficulty)
    # Ask ScrapeMarmitonService to scrape recipes details
    recipes_details = scraping_service.call
    return recipes_details
  end

  # def scrape_recipes_from_marmiton(ingredient, difficulty)
  #   if difficulty == "unknown"
  #     url = "https://www.marmiton.org/recettes/recherche.aspx?aqt=#{ingredient}"
  #   else
  #     url = "https://www.marmiton.org/recettes/recherche.aspx?aqt=#{ingredient}&dif=#{difficulty}"
  #   end
  #   # file = 'fraise.html' # or 'strawberry.html'
  #   # doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')
  #   html_doc = open(url).read
  #   doc = Nokogiri::HTML(html_doc)

  #   # Up to you to find the relevant CSS query.
  #   recipes_cards = doc.search('.recipe-card')
  #   # first_recipe_card = recipes_cards.first
  #   recipes_details = recipes_cards.first(5).map do |recipe_card|
  #     # Scrape of name
  #     recipe_name_selector = "h4.recipe-card__title"
  #     name_element = recipe_card.search(recipe_name_selector)
  #     name = name_element.text
  #     # Scrape of link
  #     recipe_link_selector = "a.recipe-card-link"
  #     link_element = recipe_card.search(recipe_link_selector)
  #     link = link_element.attribute('href').value
  #     # Scrape of description
  #     recipe_description_selector = ".recipe-card__description"
  #     description_element = recipe_card.search(recipe_description_selector)
  #     description = description_element.text.strip
  #     # Scrape of prep_time
  #     recipe_prep_time_selector = ".recipe-card__duration .recipe-card__duration__value"
  #     prep_time = recipe_card.search(recipe_prep_time_selector).text

  #     {
  #       name: name,
  #       link: link,
  #       description: description,
  #       prep_time: prep_time,
  #       difficulty: difficulty
  #     }
  #   end
  #   return recipes_details
  # end

  def mark_a_recipe_as_done
    # Display list of all recipes
    list
    # Ask View to ask user the index of the recipe to mark as done
    p index_recipe = @view.ask_user_for_recipe_index
    # Ask repository to update the done status to 'true' of the correspondant recipe
    @cookbook.update_recipe_to_done(index_recipe)
    # Display the updated list of recipes
    list
  end
end
