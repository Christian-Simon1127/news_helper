class NewsHelper::CLI
  
  def start
    display_news
    list_options
    farewell
  end 
  
  def display_news
    @news = NewsHelper::News.get_news #Nested array containing the news in order of tech, health and politics.
    puts "Hello and welcome to News_Helper! Here you can get up to date news easily, in just one character. If you'd like to see news about tech, enter '1'. If you'd like to see news about health, enter '2'. If you'd like to see news about politics, enter '3'. If you'd like to see your options again, type 'list'. To exit, please just type 'exit'."
  end 
  
  def list_options
    answer = nil 
    while answer != "exit"
      answer = gets.chomp
      if answer == '1'
        @news[0].each_with_index { |article, i| 
          puts "\n#{i+1}: #{article.headline}, #{article.publish_date} \n#{article.url}\n"
        }
      elsif answer == '2'
        @news[1].each_with_index { |article, i| 
          puts "\n#{i+1}: #{article.headline}, #{article.publish_date} \n#{article.url}\n"
        }
      elsif answer == '3'
        @news[2].each_with_index { |article, i| 
          puts "\n#{i+1}: #{article.headline}, #{article.publish_date} \n#{article.url}\n"
        }
      elsif answer == "list"
        display_news
      elsif answer.downcase == "exit"
        puts ""
        answer = "exit"
      else 
        puts "Sorry, that isn't a valid command, please re-enter your answer."
      end
    end
  end 
  
  def farewell
    puts "Thank you for using News_Helper! Come back later when there's more news!"
  end 
  
  
end