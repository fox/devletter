describe Devletter::Mail do 

  before :all do
    @mail = Devletter::Mail.new :gmail_user_name => ENV['GMAIL_USER_NAME'], :gmail_password => ENV['GMAIL_PASSWORD']
  end

  specify "build" do
    @mail.build

    @mail.html.should_not be_empty
    @mail.date.should_not be_empty
    @mail.text.should_not be_empty
    @mail.subject.should_not be_empty
  end

  specify "send" do
    begin
      @mail.send ENV['MAIL_ADDRESS']
    rescue Net::SMTPAuthenticationError => e
      puts "Cannot send email. Please specify environment vars GMAIL_USER_NAME, GMAIL_PASSWORD, MAIL_ADDRESS"
      raise e
    end
  end
end