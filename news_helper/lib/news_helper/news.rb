class NewsHelper::News
  attr_accessor :headline, :publish_time, :url
  
  def self.get_news
    news = [
    	self.scrape_tech_sites,
    	self.scrape_health_sites,
    	self.scrape_politics
  	]
  	binding.pry
  	news
  end
  
  def self.scrape_tech_sites 
  	tech_news = [] #In the order of business insider, cnn, fox news 
  	bus = Nokogiri::HTML(open("https://www.businessinsider.com/sai"))
  	cnn = Nokogiri::HTML(open("https://www.cnn.com/search?q=tech&size=5&sort=newest"))
  	fox = Nokogiri::HTML(open("https://www.foxnews.com/tech/"))
  	
  	bus.css(".river-item .featured-post").each_with_index(0) {|section, i|
  		if i < 5
  			article = self.new 
  			article.headline = bus.css("a .tout-title-link").text.strip
  			article.publish_date = bus.css(".tout-timestamp .headline-regular .js-date-format .js-rendered").text.strip
  			article.url = "https://www.businessinsider.com" + bus.css("a .tout-title-link").attribute("href").value.strip
  			tech_news << article
  		end
  	} 
  
  	cnn.css(".cnn-search__result .cnn-search_result--article").each_with_index(0) {|section, i|
  		if i < 5
  			article = self.new
  			article.headline = cnn.css("cnn-search__result-headline").text.strip
  			article.publish_date = bus.css(".cnn-search__result-publish-date").text.strip 
  			article.url = "https://www.cnn.com" + cnn.css("cnn-search__result-headline").attribute("href").value.strip
  			tech_news << article
  		end
  	}
  
  	fox.css(*css tags for headlines*).each_with_index(0) {|section, i|
  		if i < 5
  			article = self.new
  			article.headline = fox.css(".title").text.strip
  			article.publish_date = bus.css(".time").text.strip
  			article.url = "https://www.foxnews.com" + fox.css(".title").attribute("href").value.strip
  			tech_news << article
  		end
  	}
  	tech_news
  end
  
  
  
end