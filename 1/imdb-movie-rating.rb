require 'mechanize'
require 'pry'
require 'uri'

# URLs
ROOT_URL = 'https://www.imdb.com/'
QPARAMS_TITLE_SEARCH = 's=tt'

# Validation Messages
MESSAGES = {
  'missingArguments': "Missing required arguments - Try `ruby imdb-movie-rating.rb 'Interstellar' 'title'`",
  'invalidItemType': "'Invalid item type' - Try `ruby imdb-movie-rating.rb 'Interstellar' 'title'`",
}

# Validator
def validateArguments arguments
  return -1, MESSAGES[:missingArguments] if arguments.length != 2
  return -1, MESSAGES[:invalidItemType] if !['title'].include? arguments[1]
end

# Forms a search URL based on the itemName and itemType. Extensible for future usecases.
def getSearchURL itemName, itemType
  itemEncoded = URI.encode itemName
  if itemType == 'title'
    return ROOT_URL + 'find?q=' + itemEncoded + '&' +  QPARAMS_TITLE_SEARCH
  end
end

# Forms item URL
def getItemURL url
  return ROOT_URL + url
end

# Instantiates mechanize object and crawls the page.
# Returns a nokogiri object of the crawled page.
def crawlPage pageURL
  agent = Mechanize.new
  page = agent.get pageURL
  return page
end

# Returns first match from the search results.
# Retusn nil if search results are empty
def getFirstMatch page
  list = page.search('.findList')
  return nil if list.empty?
  return list.search('.findResult')[0].search('.result_text').children[1].attr('href')
end

# Returns the value of a given attribute. Extensible for future usecases.
def getValue page, attribute
  if attribute == 'rating'
    return page.search('.ratingValue').children[1].text
  end
end

# Runner
status, error = validateArguments ARGV
if status == -1
  puts error
  abort
end
pageURL = getSearchURL ARGV[0], ARGV[1]
searchResultsPage = crawlPage pageURL
match = getFirstMatch searchResultsPage
if match.nil?
  puts 'No movie found with the given search query. Try again!'
  abort
end
itemURL = getItemURL match
itemPage = crawlPage itemURL
rating = getValue itemPage, 'rating'
puts rating
