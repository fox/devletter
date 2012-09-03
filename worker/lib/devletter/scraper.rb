module Devletter

  class Scraper
    def top_story
      page = fetch_page "http://www.techmeme.com/"
      
      top_story = page.css("#topcol1 .ii")[0]

      title = top_story.css("strong a").text
      url = top_story.css("strong a").attr("href").to_s
      text = top_story.text.sub(title, "").strip.gsub(/[^a-z0-9 \.!\?"'\/]/i, '')
      
      [ url, title, text ]
    end

    def reddit_programming num_links
      links = []
      i = 0
      fetch_page("http://www.reddit.com/r/programming").css("#siteTable .entry .title a.title").each do |a|
        links << [a.attr("href"), a.text]    
        break if (i += 1) == num_links
      end
      links
    end

    def hacker_news num_links
      links = []
      i = 0
      fetch_page("http://news.ycombinator.com").css("td[class=title] a").each do |a|
        links << [a.attr("href"), a.text]    
        break if (i += 1) == num_links
      end
      links
    end

    def word_of_the_day
      page = fetch_page "http://www.wordthink.com"
      word = page.css(".category-daily-word")[0].css("p").to_s 
      word.gsub(/<[^p]+p>/, "") unless word.empty?
    end

    private 
      def fetch_page url
        cache_file = ROOT_DIR + "/cache/" + MD5.new(url + Date.today.strftime("%y-%m-%d")).to_s
        if File.exists? cache_file
           return Nokogiri::HTML File.read cache_file
        end
        
        html = open(url).read
        File.open cache_file, "w" do |f|
          f.puts html
        end
        Nokogiri::HTML html
      end
  end

end