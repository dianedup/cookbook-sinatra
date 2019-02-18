class Recipe
  attr_reader :name, :description, :link, :prep_time, :difficulty
  def initialize(name, description, link = "", prep_time = "", difficulty = "unknown", done = false)
    @name = name
    @description = description
    @link = link
    @prep_time = prep_time
    @difficulty = difficulty
    @done = done
  end

  def done?
    return @done
  end

  def mark_as_done!
    return @done = true
  end
end
