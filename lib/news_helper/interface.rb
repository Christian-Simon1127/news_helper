class NewsHelper::CLI
  
  def start
    @news = NewsHelper::News.get_news
  end 
  
  
  
  
end