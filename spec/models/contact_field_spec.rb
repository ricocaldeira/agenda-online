describe ContactField do

  before(:each) {
    @user = FactoryGirl.create(:user)
    @contact_field = FactoryGirl.create(:contact_field, name: "Field Name")
  }

  subject { @contact_field }

  it { should respond_to(:name) }

  it "#name returns a string" do
    expect(@contact_field.name).to match 'Field Name'
  end

  it "should not be valid without a name" do
    @contact_field.name = nil
    expect(@contact_field).to_not be_valid
  end

  it "should have a unique name" do
    expect(ContactField.create(name: 'Field Name')).to_not be_valid
  end
end