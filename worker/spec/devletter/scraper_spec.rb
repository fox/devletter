describe Devletter::Scraper do 

  before :all do
    @scraper = subject
  end

  it "can scrape top story" do
    url, title, text = @scraper.top_story
    url.should_not be_empty
    title.should_not be_empty
    text.should_not be_empty  
  end

  it "can scrape reddit programming" do
    links = @scraper.reddit_programming 10
    links.should_not be_empty
    links.count.should be 10
  
    url, title = links[0]
    url.should_not be_empty
    title.should_not be_empty
  end

  it "can scrape hacker news" do
    links = @scraper.hacker_news 10
    links.should_not be_empty
    links.count.should be 10
  
    url, title = links[0]
    url.should_not be_empty
    title.should_not be_empty
  end

  it "can scrape word of the day" do
    word = @scraper.word_of_the_day
    word.should_not be_empty
  end

end