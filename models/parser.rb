require 'nokogiri'
require 'open-uri'
require_relative 'recipe'

class Parser
  def initialize(keyword)
    @keyword = keyword
    @url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{keyword}"
    @doc = Nokogiri::HTML(open(@url), nil, 'utf-8')
    @html_nodes = @doc.css('.recette_classique')
  end

  def get_recipes
    recipes_string = ""
    recipes = []
    @html_nodes.css('.recette_classique').each do |element|
      element_time = element.css('.m_detail_time').text.strip.split(" ")[1] + element.css('.m_detail_time').text.strip.split(" ")[2]

      element_difficulty = element.css('.m_detail_recette').text.strip .split(' - ')[2]

      recipe = Recipe.new({
        name: element.css('.m_titre_resultat').text.strip,
        description: element.css('.m_texte_resultat').text.strip,
         cooking_time: element_time.strip, difficulty: element_difficulty})
      recipes << recipe
    end
    recipes.each do |recipe|
  end


  def print_recipe_array(recipe)
    return "[#{recipe.name}, #{recipe.description}, #{recipe.cooking_time}, #{false}, #{recipe.difficulty}]"
  end
end

# @doc.css('.m_titre_resultat').each_with_index do |title, index|
