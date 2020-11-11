class View
  def ask_user_for_recipe_details
    puts "What is the name of the recipe you want to add?"
    print "> "
    name = gets.chomp
    puts "What is the description of the recipe you want to add?"
    print "> "
    description = gets.chomp
    return { name: name, description: description }
  end

  def display_all(recipes)
    puts "Here is the up-to-date list of the recipes in your cookbook:"
    recipes.each_with_index do |recipe, index|
      if recipe.done?
        puts "#{index + 1}. [x] - #{recipe.name} (#{recipe.prep_time}) - #{recipe.description}"
      else
        puts "#{index + 1}. [ ] - #{recipe.name} (#{recipe.prep_time}) - #{recipe.description}"
      end
    end
  end

  def ask_user_for_recipe_index
    puts "What is the index of the recipe you want to select?"
    print "> "
    return gets.chomp.to_i - 1
  end

  def ask_user_for_ingredient
    puts "What ingredient would you like a recipe for?"
    print "> "
    return gets.chomp
  end

  def display_imported_recipes(recipes)
    puts "Here is the up-to-date list of the recipes in your cookbook:"
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1}. #{recipe[:name]}"
    end
  end

  def ask_user_for_difficulty_level
    puts "Do you want to add a difficulty filter? yes/no"
    print "> "
    difficulty_filter = gets.chomp
    if difficulty_filter == "yes"
      ["très facile", "facile", "moyen", "difficile"].each_with_index do |difficulty_level, index|
        puts "#{index + 1}. #{difficulty_level}"
      end
      print "Index? > "
      difficulty = gets.chomp
    else
      difficulty = "unknown"
    end
    return difficulty
  end
end
