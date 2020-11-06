# NewsHelper

Welcome to News_Helper! This gem will help find the latest news for Health, Technology and Politics. It pulls from three different websites, and grabs the first five search results of your chosen topic. All you have to do is follow the instructions given in the CLI, and it will show the title, publication time and URL for your given topic. Enjoy!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'news_helper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install news_helper

## Usage

Once started with the .start method, news_helper will ask you what topic you are most interested in out of the three given: Tech, Health and Politics. Answering with "1" will give you 15 articles equally distributed from Business Insider, Google and Fox News for a wide range of views and news. The same process will take place when given a "2" or "3" for Health and Politics respectively. After being shown the articles of your choice, you can input "y" for a direct url to the articles, while replying "n" will take you back to the main menu. You can exit whenever you want by typing "exit", where the program will then shut down.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Christian-Simon1127/news_helper.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
