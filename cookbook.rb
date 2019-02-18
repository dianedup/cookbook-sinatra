require 'csv'

class Cookbook
  # => I am the repository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    load_csv
  end

  def all
    return @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_to_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_to_csv
  end

  def save_to_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.link, recipe.prep_time, recipe.difficulty, recipe.done?]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file_path) do |row|
      # Here, row is an array of columns
      @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4], row[5] == "true")
    end
  end

  def update_recipe_to_done(index_recipe)
    @recipes[index_recipe].mark_as_done!
    save_to_csv
  end
end
