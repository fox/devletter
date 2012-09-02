describe Devletter::Mail do 

  before :all do
    @mail = subject
  end

  specify "build" do
    @mail.build

    @mail.html.should_not be_empty
    @mail.date.should_not be_empty
    @mail.text.should_not be_empty
    @mail.subject.should_not be_empty
  end
end