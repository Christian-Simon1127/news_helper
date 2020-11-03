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
  
  
  
  
  
  
  
end