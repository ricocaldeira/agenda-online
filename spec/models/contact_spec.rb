describe Contact do

  before(:each) {
    @user = FactoryGirl.create(:user)
    @contact_schema = FactoryGirl.create(:contact_schema, user_id: @user.id)
    @contact = FactoryGirl.create(:contact, user_id: @user.id)
  }

  subject { @contact }

  it { should respond_to(:name) }
  it { should respond_to(:email) }

  it "#name returns a string" do
    expect(@contact.name).to match 'Contact Name'
  end

  it "#email returns a string" do
    expect(@contact.email).to match 'contact@email.com'
  end

  it "should not be valid without an User" do
    @contact.user_id = nil
    expect(@contact).to_not be_valid
  end

  it "should not be valid without an name" do
    @contact.name = nil
    expect(@contact).to_not be_valid
  end
end
