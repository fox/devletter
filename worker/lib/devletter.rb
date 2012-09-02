require "open-uri"
require "date"
require "md5"

require "nokogiri"
require "builder"
require "mail"
require "premailer"

require "devletter/scraper"
require "devletter/mail"

module Devletter
  ROOT_DIR = File.dirname(__FILE__) + "/.."
end