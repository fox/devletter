module Devletter
  
  class Mail
    attr_accessor :date, :subject, :html, :text

    def build
      @date = Date.today.strftime("%y-%m-%d")
      scraper = Scraper.new

      b = Builder::XmlMarkup.new :indent => 2
      content = b.td(:valign => "top", :id => "content") {
        display_date = Date.today.strftime "%d.%m"
        b << "<h1>Devletter<span id='date'> &mdash; #{display_date}</span></h1>"

        url, title, text = scraper.top_story
        b.p({ :class => "top-story" }) {
          b << "<b>#{title}</b> &mdash; #{text}"
          b.a "Više", :href => url 
        }

        b.h2 "Hacker News"
        b.ol { 
          scraper.hacker_news(10).each do |url, text|
            b.li {
              b.a text, :href => url 
              b.a "(#{domain_from(url)})", :class => 'domain'
            }
          end
        }

        b.h2 "Reddit Programming"
        b.ol { 
          scraper.reddit_programming(10).each do |url, text|
            b.li {
              b.a text, :href => url 
              b.a "(#{domain_from(url)})", :class => 'domain'
            }
          end
        }

        b.h2 "Word of the day"
        b.p << scraper.word_of_the_day

        # b.p "TODO footer text", :id => "footer"
      }

      url, title, text = scraper.top_story
      @subject = title

      html = File.read(File.dirname(__FILE__) + "/email-template.html").sub('##TITLE##', @subject).sub('##CONTENT##', content)
      premailer = Premailer.new html, {
        :warn_level => Premailer::Warnings::SAFE,
        :with_html_string => true
      }
      premailer.warnings.each do |w|
        #log "#{w[:message]} (#{w[:level]}) may not render properly in #{w[:clients]}"
      end

      @html = premailer.to_inline_css
      @text = premailer.to_plain_text
    end

    def send
    end
  
    private
      def domain_from url
        url.sub(/.*:\/\//, '').sub('www.', '').sub(/\/.*/, '')
      end
    end
end