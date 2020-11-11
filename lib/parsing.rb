require 'nokogiri'

file = 'fraise.html' # or 'strawberry.html'
doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')

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
  # Scrape of duration
  recipe_duration_selector = ".recipe-card__duration .recipe-card__duration__value"
  duration = recipe_card.search(recipe_duration_selector).text

  {
    name: name,
    link: link,
    description: description,
    duration: duration
  }
end

p recipes_details
