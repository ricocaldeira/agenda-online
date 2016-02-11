describe ContactSchema do

  before(:each) {
    @contact_schema = FactoryGirl.create(:contact_schema)
    @contact_field = FactoryGirl.create(:contact_field, name: "Field Name", contact_schema_id: @contact_schema.id)
  }

  subject { @contact_schema }

  it { should respond_to(:fields) }

  it "#fields returns a string" do
    expect(@contact_schema.fields).to match [@contact_field]
  end

end
