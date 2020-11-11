require 'nokogiri'
require 'open-uri'

class ScrapeMarmitonService
  def initialize(keyword, difficulty)
    @keyword = keyword
    @difficulty = difficulty
  end

  def call
    # TODO: return a list of `Recipes` built from scraping the web.
    if @difficulty == "unknown"
      url = "https://www.marmiton.org/recettes/recherche.aspx?aqt=#{@keyword}"
    else
      url = "https://www.marmiton.org/recettes/recherche.aspx?aqt=#{@keyword}&dif=#{@difficulty}"
    end
    # file = 'fraise.html' # or 'strawberry.html'
    # doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')
    html_doc = open(url).read
    doc = Nokogiri::HTML(html_doc)

    # Up to you to find the relevant CSS query.
    recipes_cards = doc.search('.recipe-card')
    # first_recipe_card = recipes_cards.first
    recipes_details = recipes_cards.first(5).map do |recipe_card|
      # Scrape of name
      recipe_name_selector = "h4.recipe-card__title"
      name_element = recipe_card.search(recipe_name_selector)
      name = name_element.text
      # Scrape of link
      recipe_link_selector = "a.recipe-card-link"
      link_element = recipe_card.search(recipe_link_selector)
      link = link_element.attribute('href').value
      # Scrape of description
      recipe_description_selector = ".recipe-card__description"
      description_element = recipe_card.search(recipe_description_selector)
      description = description_element.text.strip
      # Scrape of prep_time
      recipe_prep_time_selector = ".recipe-card__duration .recipe-card__duration__value"
      prep_time = recipe_card.search(recipe_prep_time_selector).text

      {
        name: name,
        link: link,
        description: description,
        prep_time: prep_time,
        difficulty: @difficulty
      }
    end
    return recipes_details
  end
end

# p my_service = ScrapeMarmitonService.new("banane", "1")
# p my_service.call
