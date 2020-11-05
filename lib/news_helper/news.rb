class NewsHelper::News
  attr_accessor :headline, :publish_date, :url
  
  def self.get_news
    news = [
    	self.scrape_tech_sites#,
    	#self.scrape_health_sites,
    	#self.scrape_political_sites
  	]
  	binding.pry
  	news
  end
  
  def self.scrape_tech_sites 
  	bus = Nokogiri::HTML(URI.open("https://www.businessinsider.com/sai"))
  	cnn = Nokogiri::HTML(URI.open("https://www.cnn.com/search?q=tech&size=5&sort=newest"))
  	fox = Nokogiri::HTML(URI.open("https://www.foxnews.com/tech/"))
  	#Below, every news site will have their articles stored below. It will store all of the 
  	#articles on the page before they are sorted and capped at 5 per website. Thanks to the consistency 
  	#of the page's CSS, it is easy to use one method to scrape multiple pages of the same site.
  	bus_news = scrape_bus_ins(bus)
  	cnn_news = []
  	fox_news = []
  
  	cnn.css(".cnn-search__result .cnn-search_result--article").each {|section|
  			article = self.new
  			article.headline = cnn.css("cnn-search__result-headline").text.strip
  			article.publish_date = bus.css(".cnn-search__result-publish-date").text.strip 
  			article.url = "https://www.cnn.com" + cnn.css("cnn-search__result-headline").attribute("href").value.strip
  			cnn_news << article
  	}
  
  	fox.css("article .article").each {|section|
  			article = self.new
  			article.headline = fox.css(".title").text.strip
  			article.publish_date = bus.css(".time").text.strip
  			article.url = "https://www.foxnews.com" + fox.css(".title").attribute("href").value.strip
  			fox_news << article
  	}
  	
  	sort_news(bus_news, cnn_news, fox_news)
  end
  
  def self.scrape_health_sites 
  	health_news = []
  	bus = Nokogiri::HTML(URI.open("https://www.businessinsider.com/healthcare")) 
  	cnn = Nokogiri::HTML(URI.open("https://www.cnn.com/health"))
  	fox = Nokogiri::HTML(URI.open("https://www.foxnews.com/health"))
  	
  	bus.css("#l-content").each_with_index {|section|
  			article = self.new 
  			article.headline = bus.css("a .tout-title-link").text.strip
  			article.publish_date = bus.css(".tout-timestamp .headline-regular .js-date-format .js-rendered").text.strip
  			article.url = "https://www.businessinsider.com" + bus.css("a.tout-title-link").attribute("href").value.strip
  			tech_news << article
  	} 
  
  	cnn.css(".cnn-search__result .cnn-search_result--article").each_with_index {|section|
  			article = self.new
  			article.headline = cnn.css("cnn-search__result-headline").text.strip
  			article.publish_date = bus.css(".cnn-search__result-publish-date").text.strip 
  			article.url = cnn.css("cnn-search__result-headline").attribute("href").value.strip
  			health_news << article
  	}
  
  	fox.css("article .article").each_with_index {|section|
  			article = self.new
  			article.headline = fox.css(".title").text.strip
  			article.publish_date = bus.css(".time").text.strip
  			article.url = "https://www.foxnews.com" + fox.css(".title").attribute("href").value.strip
  			health_news << article
  	}
  	health_news
  end  
  
  def self.scrape_political_sites 
  	poli_news = [] 
  	bus = Nokogiri::HTML(URI.open("https://www.businessinsider.com/s?q=politics"))
  	cnn = Nokogiri::HTML(URI.open("https://www.cnn.com/search?q=politics"))
  	fox = Nokogiri::HTML(URI.open("https://www.foxnews.com/politics/"))
  	
  	scrape_bus_ins(bus)
  
  	cnn.css(".cnn-search__result .cnn-search_result--article").each_with_index {|section, i|
  			article = self.new
  			article.headline = cnn.css("cnn-search__result-headline").text.strip
  			article.publish_date = bus.css(".cnn-search__result-publish-date").text.strip 
  			article.url = cnn.css("cnn-search__result-headline").attribute("href").value.strip
  			poli_news << article
  	}
  
  	fox.css("article .article").each_with_index {|section, i|
  			article = self.new
  			article.headline = fox.css(".title").text.strip
  			article.publish_date = bus.css(".time").text.strip
  			article.url = "https://www.foxnews.com" + fox.css(".title").attribute("href").value.strip
  			poli_news << article
  	}
  	poli_news
  end
  
  def self.scrape_bus_ins(bus_page)
    scraped_news = []
  	bus_page.css(".river-item.featured-post").each {|section|
  			article = self.new 
  			article.headline = section.css("a.tout-title-link").text.strip
  			article.publish_date = section.css("span.tout-timestamp").text.split("T")[0]
  			article.url = "https://www.businessinsider.com" + section.css("a.tout-title-link").attribute("href").value.strip
  			scraped_news << article
  	} 
  	scraped_news
  end
  
  
  def self.sort_news(source_1, source_2, source_3)
    sorted_news = [] #This will be the array of 15 articles, five from each website
  	5.times { |i|
  	  sorted_news << source_1[i]
  	  sorted_news << source_2[i]
  	  sorted_news << source_3[i]
  	}
  	sorted_news
  end
  
end