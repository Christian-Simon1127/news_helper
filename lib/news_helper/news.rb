class NewsHelper::News
  attr_accessor :headline, :publish_date, :url
  
  def self.get_news
    news = [
    	self.scrape_tech_sites,
    	self.scrape_health_sites,
    	self.scrape_political_sites
  	]
  end
  
  def self.scrape_tech_sites 
  	bus = Nokogiri::HTML(URI.open("https://www.businessinsider.com/sai"))
  	google = Nokogiri::HTML(URI.open("https://news.google.com/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRGRqTVhZU0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen"))
  	fox = Nokogiri::HTML(URI.open("https://www.foxnews.com/tech/"))
    #The below method calls methods designed to scrape business insider, google and fox news 
 
  	sort_news(scrape_bus_ins(bus), scrape_google_news(google), scrape_fox_news(fox))
  end
  
  def self.scrape_health_sites 
  	health_news = []
  	bus = Nokogiri::HTML(URI.open("https://www.businessinsider.com/healthcare")) 
  	google = Nokogiri::HTML(URI.open("https://news.google.com/topics/CAAqIQgKIhtDQkFTRGdvSUwyMHZNR3QwTlRFU0FtVnVLQUFQAQ?hl=en-US&gl=US&ceid=US%3Aen"))
  	fox = Nokogiri::HTML(URI.open("https://www.foxnews.com/health"))
  	
  	sort_news(scrape_bus_ins(bus), scrape_google_news(google), scrape_fox_news(fox))
  end  
  
  def self.scrape_political_sites 
  	poli_news = [] 
  	bus = Nokogiri::HTML(URI.open("https://www.businessinsider.com/s?q=politics"))
  	google = Nokogiri::HTML(URI.open("https://news.google.com/topics/CAAqIQgKIhtDQkFTRGdvSUwyMHZNRFZ4ZERBU0FtVnVLQUFQAQ?hl=en-US&gl=US&ceid=US%3Aen"))
  	fox = Nokogiri::HTML(URI.open("https://www.foxnews.com/politics/"))
  	
  	sort_news(scrape_bus_ins(bus), scrape_google_news(google), scrape_fox_news(fox))
  end
  
  def self.scrape_bus_ins(bus_page)
    scraped_news = [] #To hold and return the News objects
  	bus_page.css(".river-item.featured-post").each {|section|
  			article = self.new 
  			article.headline = section.css("a.tout-title-link").text.strip
  			article.publish_date = section.css("span.tout-timestamp").text.split("T")[0]
  			article.url = "https://www.businessinsider.com" + section.css("a.tout-title-link").attribute("href").value.strip
  			scraped_news << article
  	} 
  	scraped_news
  end
  
  def self.scrape_google_news(google_page)
    scraped_news = []
  	google_page.css(".xrnccd.F6Welf.R7GTQ.keNKEd.j7vNaf").each {|section|
  			article = self.new
  			article.headline = section.css("a.DY5T1d").first.text
  			article.publish_date = section.css(".WW6dff.uQIVzc.Sksgp").first.text.strip 
  			article.url = "https://news.google.com" + section.css(".VDXfz").attribute("href").value.strip
  			scraped_news << article
  	}
  	scraped_news
  end
  
  def self.scrape_fox_news(fox_page)
    scraped_news = []
    articles = fox_page.css(".content.article-list") #This is to avoid some more off-topic articles at the top of the page
  	articles.css("article.article").each {|section|
  			article = self.new
  			article.headline = section.css(".title").text.strip
  			article.publish_date = section.css(".time").text.strip
  			article.url = "https://www.foxnews.com" + section.css(".m").css("a").attribute("href").value.strip
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